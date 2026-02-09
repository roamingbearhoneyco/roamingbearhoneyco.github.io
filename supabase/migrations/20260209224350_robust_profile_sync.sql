-- 1. Hardened Sync Function with logic for partial updates (Name, Email, or Both)
CREATE OR REPLACE FUNCTION public.sync_profile_to_brevo()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'extensions', 'vault'
 AS $$
DECLARE
  res extensions.http_response;
  v_service_key TEXT;
  v_tier_name TEXT;
BEGIN
  -- LOOP & RECURSION PREVENTION
  -- This check ensures we ONLY ping Brevo if the core identity data changed.
  -- If only 'last_synced' or 'merch_preferences' changed, this returns immediately.
  IF (OLD.first_name IS NOT DISTINCT FROM NEW.first_name) AND 
     (OLD.email IS NOT DISTINCT FROM NEW.email) THEN
    RETURN NEW;
  END IF;

  -- DATA MAPPING
  -- Find the subscription tier using the profile's primary key (id)
  SELECT t.name INTO v_tier_name
  FROM public.subscriptions s
  JOIN public.subscription_tiers t ON s.tier_id = t.id
  WHERE s.profile_id = NEW.id
  LIMIT 1;

  -- AUTHORIZATION
  SELECT decrypted_secret INTO v_service_key 
  FROM vault.decrypted_secrets 
  WHERE name = 'service_role_key';

  IF v_service_key IS NULL THEN
    RAISE LOG 'Brevo Sync Failed: service_role_key not found in Vault';
    RETURN NEW;
  END IF;

  -- EXTERNAL SYNC
  -- Using the working extensions.http pattern
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
        'email', NEW.email,
        'tier', COALESCE(v_tier_name, 'free'),
        'first_name', COALESCE(NEW.first_name, 'Friend')
      )::text
    )::extensions.http_request
  );

  RETURN NEW;
END;
$$;

-- 2. Ensure Trigger is attached correctly to the Profile table
DROP TRIGGER IF EXISTS on_profile_update_sync_brevo ON public."rbhc-table-profiles";

CREATE TRIGGER on_profile_update_sync_brevo
  AFTER UPDATE ON public."rbhc-table-profiles"
  FOR EACH ROW
  EXECUTE FUNCTION public.sync_profile_to_brevo();