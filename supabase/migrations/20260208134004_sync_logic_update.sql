BEGIN;

-- 1. REFINED PROFILE INSERT TRIGGER (Handling Duplicates)
-- This logic ensures that if an email exists, we don't overwrite it if they are already an Auth user.
CREATE OR REPLACE FUNCTION public.handle_profile_insert_logic() 
RETURNS TRIGGER AS $$
BEGIN
  -- If the email exists and already has a user_id, it means they are a registered Auth user.
  -- We prevent the frontend from overwriting this record.
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
  FOR EACH ROW EXECUTE FUNCTION public.handle_profile_insert_logic();


-- 2. BREVO SYNC TRIGGER (The Webhook Payload)
-- This function gathers the Name, Email, and Tier from the related tables
CREATE OR REPLACE FUNCTION public.get_brevo_payload() 
RETURNS TRIGGER AS $$
DECLARE
  payload JSONB;
BEGIN
  SELECT jsonb_build_object(
    'email', p.email,
    'first_name', p.first_name,
    'tier', st.name,
    'profile_id', p.id
  ) INTO payload
  FROM public."rbhc-table-profiles" p
  JOIN public.subscription_tiers st ON st.id = NEW.tier_id
  WHERE p.id = NEW.profile_id;

  -- Trigger the Edge Function via Supabase Webhook (configured in Dashboard)
  -- Or manually using net.http_post if you have the extension enabled
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS on_subscription_created_sync_brevo ON public.subscriptions;
CREATE TRIGGER on_subscription_created_sync_brevo
  AFTER INSERT OR UPDATE OF tier_id ON public.subscriptions
  FOR EACH ROW EXECUTE FUNCTION public.get_brevo_payload();

COMMIT;