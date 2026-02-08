BEGIN;

CREATE OR REPLACE FUNCTION public.sync_subscription_to_brevo() 
RETURNS trigger 
LANGUAGE plpgsql SECURITY DEFINER
SET search_path TO 'public', 'extensions'
AS $$
DECLARE
  res extensions.http_response;
  response_json jsonb;
  brevo_id text;
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

  -- 3. Call Edge Function (Updated Path to sync-brevo-contact)
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
        'tier', COALESCE(v_tier_name, 'Free'),
        'first_name', COALESCE(v_first_name, 'Friend')
      )::text
    )::extensions.http_request
  );

  -- 4. Parse response
  -- Note: We only update if we get a brevo_contact_id back (Status 201)
  IF res.status = 201 THEN
    response_json := res.content::jsonb;
    brevo_id := response_json->>'brevo_contact_id';

    IF brevo_id IS NOT NULL THEN
      UPDATE public."rbhc-table-profiles"
      SET brevo_id = brevo_id,
          last_synced = NOW()
      WHERE id = NEW.profile_id;
    END IF;
  END IF;

  RETURN NEW;
END;
$$;

COMMIT;