BEGIN;

-- 1. Drop the old trigger so we can remove the old function name
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

-- 2. Drop the old function name
DROP FUNCTION IF EXISTS public.handle_new_user();

-- 3. Create the function with the new name: handle_new_auth_user
CREATE OR REPLACE FUNCTION public.handle_new_auth_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER 
SET search_path = public
AS $$
BEGIN
  -- Check if a profile with this email already exists (Lead-to-Customer flow)
  IF EXISTS (SELECT 1 FROM public."rbhc-table-profiles" WHERE email = NEW.email) THEN
    UPDATE public."rbhc-table-profiles"
    SET 
      user_id = NEW.id,
      -- Fill in name from metadata if it was missing in the lead row
      first_name = COALESCE(first_name, NEW.raw_user_meta_data->>'first_name')
    WHERE email = NEW.email;
    
  -- Create new profile if they didn't exist (Direct Signup flow)
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

-- 4. Re-attach the trigger using the NEW function name
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_auth_user();

COMMIT;