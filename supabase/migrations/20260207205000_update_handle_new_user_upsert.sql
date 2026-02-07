-- Migration: Update handle_new_user to UPSERT by email
-- Date: 2025-02-07
-- Purpose: When auth user signs up, check if email already exists in profiles (from onboard).
--          If yes, UPDATE the user_id. If no, INSERT new profile.
--          This allows seamless migration from email-only leads to authenticated users.

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
    user_id = excluded.user_id,
    created_at = COALESCE(public."rbhc-table-profiles".created_at, excluded.created_at)
  WHERE public."rbhc-table-profiles".user_id IS NULL;

  RETURN new;
END;
$$;

-- ============================================================================
-- ROLLBACK INSTRUCTIONS
-- ============================================================================
--
-- To rollback this migration:
--
-- CREATE OR REPLACE FUNCTION public.handle_new_user()
-- RETURNS trigger
-- LANGUAGE plpgsql
-- SECURITY DEFINER
-- SET search_path = public
-- AS $$
-- BEGIN
--   INSERT INTO public."rbhc-table-profiles" (user_id, created_at, email)
--   VALUES (new.id, now(), new.email)
--   ON CONFLICT (email) DO UPDATE
--   SET 
--     user_id = excluded.user_id
--   WHERE public."rbhc-table-profiles".user_id IS NULL;
--
--   RETURN new;
-- END;
-- $$;
