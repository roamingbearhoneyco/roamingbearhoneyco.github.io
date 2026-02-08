-- 1. Ensure required extensions and schemas are accessible
CREATE SCHEMA IF NOT EXISTS extensions;
GRANT USAGE ON SCHEMA extensions TO postgres, authenticated, service_role;

-- 2. Update Auth Signup Trigger (Handles Google/OAuth names)
-- Extracts only the first word from the name provided by the provider
CREATE OR REPLACE FUNCTION public.handle_new_auth_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  IF EXISTS (SELECT 1 FROM public."rbhc-table-profiles" WHERE email = NEW.email) THEN
    UPDATE public."rbhc-table-profiles"
    SET 
      user_id = NEW.id,
      first_name = COALESCE(
        first_name, 
        NEW.raw_user_meta_data->>'first_name',
        split_part(NEW.raw_user_meta_data->>'full_name', ' ', 1),
        split_part(NEW.raw_user_meta_data->>'name', ' ', 1),
        'Friend'
      )
    WHERE email = NEW.email;
  ELSE
    INSERT INTO public."rbhc-table-profiles" (user_id, email, first_name)
    VALUES (
      NEW.id,
      NEW.email,
      COALESCE(
        NEW.raw_user_meta_data->>'first_name',
        split_part(NEW.raw_user_meta_data->>'full_name', ' ', 1),
        split_part(NEW.raw_user_meta_data->>'name', ' ', 1),
        'Friend'
      )
    );
  END IF;
  RETURN NEW;
END;
$$;

-- 3. Brevo Sync Function (Logic & Edge Function Call)
-- This includes loop prevention via the "IS DISTINCT FROM" check
CREATE OR REPLACE FUNCTION public.sync_profile_to_brevo() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public', 'extensions', 'vault'
    AS $$
DECLARE
  v_tier_name TEXT;
  v_service_key TEXT;
BEGIN
  -- LOOP PREVENTION: Only trigger if the first_name actually changed
  IF (OLD.first_name IS DISTINCT FROM NEW.first_name) THEN
    
    -- Fetch current subscription tier name
    SELECT t.name INTO v_tier_name
    FROM public.subscriptions s
    JOIN public.subscription_tiers t ON s.tier_id = t.id
    WHERE s.profile_id = NEW.id
    LIMIT 1;

    -- Fetch Service Role Key for Authorization
    SELECT decrypted_secret INTO v_service_key 
    FROM vault.decrypted_secrets WHERE name = 'service_role_key';

    -- Call Edge Function
    PERFORM extensions.http_post(
      'https://roqwrtsmcisdxhgthpem.supabase.co/functions/v1/sync-brevo-contact',
      json_build_object(
        'email', NEW.email,
        'tier', COALESCE(v_tier_name, 'free'),
        'first_name', NEW.first_name
      )::jsonb,
      headers := jsonb_build_object(
        'Authorization', 'Bearer ' || v_service_key,
        'Content-Type', 'application/json'
      )
    );
  END IF;
  RETURN NEW;
END;
$$;

-- 4. Re-attach Triggers
DROP TRIGGER IF EXISTS on_profile_update_sync_brevo ON public."rbhc-table-profiles";

CREATE TRIGGER on_profile_update_sync_brevo
  AFTER UPDATE ON public."rbhc-table-profiles"
  FOR EACH ROW
  EXECUTE FUNCTION public.sync_profile_to_brevo();

-- 5. Fix Permissions (Crucial to prevent 404/403 errors during update)
GRANT USAGE ON SCHEMA vault TO postgres;
GRANT SELECT ON vault.decrypted_secrets TO postgres;