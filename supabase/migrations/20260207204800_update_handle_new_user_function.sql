-- Migration: Update handle_new_user function to remove subscription_tier
-- Date: 2025-02-07
-- Purpose: Remove subscription_tier setting from handle_new_user since subscriptions
--          are now managed in the subscriptions table with auto-creation via trigger

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public."rbhc-table-profiles" (user_id, created_at, email)
  VALUES (new.id, now(), new.email)
  ON CONFLICT (email) DO UPDATE
  SET 
    user_id = excluded.user_id
  WHERE public."rbhc-table-profiles".user_id IS NULL;

  RETURN new;
END;
$$;

-- ============================================================================
-- ROLLBACK INSTRUCTIONS
-- ============================================================================
--
-- To rollback this migration, restore the previous function version:
--
-- CREATE OR REPLACE FUNCTION public.handle_new_user()
-- RETURNS trigger
-- LANGUAGE plpgsql
-- SECURITY DEFINER
-- SET search_path = public
-- AS $$
-- BEGIN
--   insert into public."rbhc-table-profiles" (user_id, subscription_tier, created_at, email)
--   values (new.id, 'conditional', now(), new.email)
--   on conflict (email) do update
--   set 
--     user_id = excluded.user_id,
--     subscription_tier = excluded.subscription_tier
--   where public."rbhc-table-profiles".user_id is null;
--
--   return new;
-- end;
-- $$;
