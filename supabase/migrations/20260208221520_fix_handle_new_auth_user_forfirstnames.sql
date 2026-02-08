-- 1. THE FUNCTION (Lives in 'public' to interact with your profiles)
CREATE OR REPLACE FUNCTION public.handle_new_auth_user()
RETURNS TRIGGER AS $$
BEGIN
  IF EXISTS (SELECT 1 FROM public."rbhc-table-profiles" WHERE email = NEW.email) THEN
    UPDATE public."rbhc-table-profiles"
    SET 
      user_id = NEW.id,
      first_name = COALESCE(
        first_name, 
        NEW.raw_user_meta_data->>'given_name',
        NEW.raw_user_meta_data->>'first_name',
        'Friend'
      )
    WHERE email = NEW.email;
  ELSE
    INSERT INTO public."rbhc-table-profiles" (user_id, email, first_name)
    VALUES (
      NEW.id,
      NEW.email,
      COALESCE(
        NEW.raw_user_meta_data->>'given_name',
        NEW.raw_user_meta_data->>'first_name',
        'Friend'
      )
    );
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 2. THE TRIGGER (Targets the 'auth' schema)
-- We explicitly use the schema prefix 'auth.' before the table name 'users'
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users -- <--- This 'auth.' prefix is what dictates the schema
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_auth_user();