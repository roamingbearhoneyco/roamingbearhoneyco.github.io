BEGIN;

-- 1. Update the function to handle both "Linking" and "Creating"
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER 
SET search_path = public
AS $$
BEGIN
  -- SCENARIO 1: The user already exists in profiles (from the email modal)
  -- We just update their record with the new Auth UUID.
  IF EXISTS (SELECT 1 FROM public."rbhc-table-profiles" WHERE email = NEW.email) THEN
    UPDATE public."rbhc-table-profiles"
    SET 
      user_id = NEW.id,
      -- If they didn't have a name yet, take it from auth metadata if available
      first_name = COALESCE(first_name, NEW.raw_user_meta_data->>'first_name')
    WHERE email = NEW.email;
    
  -- SCENARIO 2: Brand new user (Direct Signup)
  -- We create a fresh profile row for them.
  ELSE
    INSERT INTO public."rbhc-table-profiles" (user_id, email, first_name)
    VALUES (
      NEW.id,
      NEW.email,
      NEW.raw_user_meta_data->>'first_name'
    );
  END IF;

  RETURN NEW;
END;
$$;

-- 2. Re-attach the trigger to the Auth table
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

COMMIT;