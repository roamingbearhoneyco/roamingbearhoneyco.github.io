CREATE OR REPLACE FUNCTION public.handle_profile_insert_gatekeeper()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 -- This line fixes the warning
 SET search_path TO 'public'
AS $$
BEGIN
  -- If user_id is null, it means it's a pre-sign-up entry (like an email capture)
  -- We allow these to proceed.
  IF NEW.user_id IS NULL THEN
    RETURN NEW;
  END IF;

  -- If user_id is NOT null, it's an auth-linked profile. 
  -- We check if a profile already exists for this email.
  IF EXISTS (
    SELECT 1 FROM public."rbhc-table-profiles" 
    WHERE email = NEW.email AND user_id IS NULL
  ) THEN
    -- If an orphan profile exists, we update it instead of inserting a new one
    UPDATE public."rbhc-table-profiles"
    SET user_id = NEW.user_id,
        first_name = COALESCE(NEW.first_name, first_name)
    WHERE email = NEW.email AND user_id IS NULL;
    RETURN NULL; -- Cancel the insert because we handled it via update
  END IF;

  RETURN NEW;
END;
$$;