-- Migration: Create trigger for email-only leads (onboard) to auto-create FREE subscriptions
-- Date: 2025-02-07
-- Purpose: When a profile is inserted with NULL user_id (from onboard), auto-create a FREE subscription.
--          When profile is later UPDATEd with a real user_id (from auth signup), subscription already exists.

CREATE OR REPLACE FUNCTION public.create_subscription_for_email_lead()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  free_tier_id BIGINT;
BEGIN
  -- Get the 'free' tier ID
  SELECT id INTO free_tier_id FROM public.subscription_tiers WHERE name = 'free' LIMIT 1;
  
  IF free_tier_id IS NULL THEN
    RAISE LOG 'Free tier not found in subscription_tiers table';
    RETURN NEW;
  END IF;
  
  -- Create subscription for email-only leads (user_id is NOT NULL but came from onboard)
  -- This happens for both:
  -- 1. New email-only leads (INSERT with user_id from onboard UUID)
  -- 2. Existing leads getting authenticated (UPDATE with user_id from auth)
  INSERT INTO public.subscriptions (user_id, tier_id, billing_cycle, status)
  VALUES (NEW.user_id, free_tier_id, 1, 'active')
  ON CONFLICT (user_id) DO NOTHING;
  
  RETURN NEW;
END;
$$;

-- Drop old trigger if it exists
DROP TRIGGER IF EXISTS on_profile_insert_create_subscription ON public."rbhc-table-profiles";

-- Create new trigger for both INSERT and UPDATE
CREATE TRIGGER on_profile_create_or_update_subscription
  AFTER INSERT OR UPDATE ON public."rbhc-table-profiles"
  FOR EACH ROW
  WHEN (NEW.user_id IS NOT NULL)
  EXECUTE FUNCTION public.create_subscription_for_email_lead();

-- ============================================================================
-- ROLLBACK INSTRUCTIONS
-- ============================================================================
--
-- To rollback this migration:
--
-- DROP TRIGGER IF EXISTS on_profile_create_or_update_subscription ON public."rbhc-table-profiles";
-- DROP FUNCTION IF EXISTS public.create_subscription_for_email_lead();
--
-- CREATE TRIGGER on_profile_insert_create_subscription
--   AFTER INSERT ON public."rbhc-table-profiles"
--   FOR EACH ROW
--   WHEN (NEW.user_id IS NOT NULL)
--   EXECUTE FUNCTION public.create_subscription_for_new_user();
