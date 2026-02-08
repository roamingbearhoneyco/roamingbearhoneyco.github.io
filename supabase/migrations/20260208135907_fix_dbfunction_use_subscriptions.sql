BEGIN;

-- 1. THE GATEKEEPER (For the Frontend Modal)
CREATE OR REPLACE FUNCTION public.handle_profile_insert_gatekeeper() 
RETURNS TRIGGER AS $$
BEGIN
  -- If email exists and is already linked to an Auth User, block the insert
  IF EXISTS (
    SELECT 1 FROM public."rbhc-table-profiles" 
    WHERE email = NEW.email AND user_id IS NOT NULL
  ) THEN
    RAISE EXCEPTION 'ALREADY_REGISTERED';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS on_profile_insert_gatekeeper ON public."rbhc-table-profiles";
CREATE TRIGGER on_profile_insert_gatekeeper
  BEFORE INSERT ON public."rbhc-table-profiles"
  FOR EACH ROW EXECUTE FUNCTION public.handle_profile_insert_gatekeeper();

-- 2. THE BREVO SYNCER (Refactored to your exact logic)
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
  -- We need to fetch the Profile details because they aren't in the NEW subscription record
  SELECT email, first_name INTO v_email, v_first_name
  FROM public."rbhc-table-profiles"
  WHERE id = NEW.profile_id;

  SELECT name INTO v_tier_name
  FROM public.subscription_tiers
  WHERE id = NEW.tier_id;

  -- 1. Vault Secret Check (Your original logic)
  SELECT decrypted_secret INTO v_service_key 
  FROM vault.decrypted_secrets 
  WHERE name = 'service_role_key';

  IF v_service_key IS NULL THEN
    RAISE LOG 'Vault secret service_role_key not found!';
    RETURN NEW;
  END IF;

  -- 2. Call Edge Function (Your original syntax)
  res := extensions.http(
    (
      'POST', 
      'https://roqwrtsmcisdxhgthpem.supabase.co/functions/v1/sync-brevo',
      ARRAY[
        extensions.http_header('Authorization', 'Bearer ' || v_service_key),
        extensions.http_header('Content-Type', 'application/json')
      ],
      'application/json',
      json_build_object(
        'email', v_email,
        'tier', COALESCE(v_tier_name, 'OOPS'),
        'first_name', COALESCE(v_first_name, 'Friend')
      )::text
    )::extensions.http_request
  );

  -- 3. Parse and Update (Only if ID is returned, prevents loops)
  response_json := res.content::jsonb;
  brevo_id := response_json->>'brevo_contact_id';

  IF brevo_id IS NOT NULL THEN
    UPDATE public."rbhc-table-profiles"
    SET brevo_id = brevo_id, -- Matches your schema's column name
        last_synced = NOW()
    WHERE id = NEW.profile_id;
  END IF;

  RETURN NEW;
END;
$$;

-- 3. RE-ATTACH TRIGGER
DROP TRIGGER IF EXISTS on_subscription_created_sync ON public.subscriptions;
CREATE TRIGGER on_subscription_created_sync
  AFTER INSERT OR UPDATE OF tier_id ON public.subscriptions
  FOR EACH ROW EXECUTE FUNCTION public.sync_subscription_to_brevo();

COMMIT;