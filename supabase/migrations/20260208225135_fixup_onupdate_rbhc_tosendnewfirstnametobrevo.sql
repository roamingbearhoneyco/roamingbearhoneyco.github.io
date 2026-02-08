-- Create the function to sync profile changes
CREATE OR REPLACE FUNCTION public.sync_profile_to_brevo() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public', 'extensions'
    AS $$
BEGIN
  -- LOOP PREVENTION: Only trigger if the name actually changed
  IF (OLD.first_name IS DISTINCT FROM NEW.first_name) THEN
    -- We reuse your existing logic but fetch the current tier first
    DECLARE
      v_tier_name TEXT;
      v_service_key TEXT;
    BEGIN
      SELECT t.name INTO v_tier_name
      FROM public.subscriptions s
      JOIN public.subscription_tiers t ON s.tier_id = t.id
      WHERE s.profile_id = NEW.id
      LIMIT 1;

      SELECT decrypted_secret INTO v_service_key 
      FROM vault.decrypted_secrets WHERE name = 'service_role_key';

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
    END;
  END IF;
  RETURN NEW;
END;
$$;

-- Attach the trigger to the profiles table
CREATE TRIGGER on_profile_update_sync_brevo
  AFTER UPDATE ON public."rbhc-table-profiles"
  FOR EACH ROW
  EXECUTE FUNCTION public.sync_profile_to_brevo();