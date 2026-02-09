CREATE OR REPLACE FUNCTION public.sync_profile_to_brevo()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 -- Fixes the security warning and ensures extensions are found
 SET search_path TO 'public', 'extensions', 'vault'
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
  -- NOTE: Based on your code, this trigger likely runs on a 'subscriptions' table
  -- since it uses NEW.profile_id and NEW.tier_id
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
  IF res.status = 201 THEN
    response_json := res.content::jsonb;
    v_brevo_id := response_json->>'brevo_contact_id';

    IF v_brevo_id IS NOT NULL THEN
      -- Use a direct update that won't re-trigger itself infinitely
      UPDATE public."rbhc-table-profiles"
      SET brevo_contact_id = v_brevo_id,
          last_synced = NOW()
      WHERE id = NEW.profile_id;
    END IF;
  END IF;

  RETURN NEW;
END;
$$;