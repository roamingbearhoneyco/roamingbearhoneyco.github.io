BEGIN;

-- 1. DROP ALL TRIGGERS ON ALL TABLES
-- This unlocks the functions so they can be deleted.

-- From Profiles Table
DROP TRIGGER IF EXISTS on_profile_upsert ON public."rbhc-table-profiles";
DROP TRIGGER IF EXISTS trigger_brevo_sync ON public."rbhc-table-profiles";
DROP TRIGGER IF EXISTS on_profile_update_sync ON public."rbhc-table-profiles";
DROP TRIGGER IF EXISTS on_lead_created_create_subscription ON public."rbhc-table-profiles";
DROP TRIGGER IF EXISTS on_profile_create_or_update_subscription ON public."rbhc-table-profiles";
DROP TRIGGER IF EXISTS on_profile_insert_gatekeeper ON public."rbhc-table-profiles";
DROP TRIGGER IF EXISTS on_profile_created_assign_sub ON public."rbhc-table-profiles";

-- From Subscriptions Table
DROP TRIGGER IF EXISTS on_subscription_created_sync_brevo ON public.subscriptions;
DROP TRIGGER IF EXISTS on_subscription_created_sync ON public.subscriptions;

-- From Auth Users Table
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;


-- 2. DROP THE STALE FUNCTIONS
-- Now that the links are cut, these will delete cleanly.

DROP FUNCTION IF EXISTS public.call_brevo_sync();
DROP FUNCTION IF EXISTS public.get_brevo_payload();
DROP FUNCTION IF EXISTS public.create_subscription_for_email_lead();
DROP FUNCTION IF EXISTS public.create_subscription_for_new_user();
DROP FUNCTION IF EXISTS public.handle_profile_insert_logic();


-- 3. RE-ESTABLISH ONLY THE CURRENT LOGIC
-- This puts back the triggers required for your Modal and your Sync.

-- A) Trigger for assigning Free Subscription when a profile is created
CREATE TRIGGER on_profile_created_assign_sub
  AFTER INSERT ON public."rbhc-table-profiles"
  FOR EACH ROW EXECUTE FUNCTION public.create_subscription_for_new_profile();

-- B) Trigger for blocking Modal from overwriting Auth users
CREATE TRIGGER on_profile_insert_gatekeeper
  BEFORE INSERT ON public."rbhc-table-profiles"
  FOR EACH ROW EXECUTE FUNCTION public.handle_profile_insert_gatekeeper();

-- C) Trigger for syncing to Brevo when the subscription is created
CREATE TRIGGER on_subscription_created_sync
  AFTER INSERT OR UPDATE OF tier_id ON public.subscriptions
  FOR EACH ROW EXECUTE FUNCTION public.sync_subscription_to_brevo();

COMMIT;