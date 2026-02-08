BEGIN;

-- We update the function to map the Brevo ID to the correct column: brevo_contact_id
CREATE OR REPLACE FUNCTION public.sync_subscription_to_brevo() 
RETURNS trigger 
LANGUAGE plpgsql SECURITY DEFINER
SET search_path TO 'public', 'extensions'
AS $$
DECLARE
  res extensions.http_response;
  response_json jsonb;
  v_brevo_id text;
  v_service_key TEXT;
  v_email TEXT;
  v_first_name TEXT;
  v_tier_name TEXT;
BEGIN
  -- 1. Gather Profile and Tier details
  SELECT email, first_name INTO v_email, v_first_name
  FROM public."rbhc-table-profiles"
  WHERE id = NEW.profile_id;

  SELECT name INTO v_tier_name
  FROM public.subscription_tiers
  WHERE id = NEW.tier_id;

  -- 2. Vault Secret Check
  SELECT decrypted_secret INTO v_service_key 
  FROM vault.decrypted_secrets 
  WHERE name = 'service_role_key';

  IF v_service_key IS NULL THEN
    RAISE LOG 'Vault secret service_role_key not found!';
    RETURN NEW;
  END IF;

  -- 3. Call Edge Function (Ensuring correct URL)
  res := extensions.http(
    (
      'POST', 
      'https://roqwrtsmcisdxhgthpem.supabase.co/functions/v1/sync-brevo-contact',
      ARRAY[
        extensions.http_header('Authorization', 'Bearer ' || v_service_key),
        extensions.http_header('Content-Type', 'application/json')
      ],
      'application/json',
      json_build_object(
        'email', v_email,
        'tier', COALESCE(v_tier_name, 'oops'),
        'first_name', COALESCE(v_first_name, 'oops')
      )::text
    )::extensions.http_request
  );

  -- 4. Parse response and update the CORRECT column
  -- Only update on 201 (New Contact Created)
  IF res.status = 201 THEN
    response_json := res.content::jsonb;
    v_brevo_id := response_json->>'brevo_contact_id';

    IF v_brevo_id IS NOT NULL THEN
      UPDATE public."rbhc-table-profiles"
      SET brevo_contact_id = v_brevo_id,  -- Correct column name
          last_synced = NOW()
      WHERE id = NEW.profile_id;
    END IF;
  END IF;

  RETURN NEW;
END;
$$;

COMMIT;