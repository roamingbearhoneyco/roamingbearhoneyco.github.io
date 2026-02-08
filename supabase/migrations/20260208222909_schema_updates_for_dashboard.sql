-- 1. Update the function to catch more Google metadata keys
CREATE OR REPLACE FUNCTION public.handle_new_auth_user()
RETURNS TRIGGER AS $$
BEGIN
  IF EXISTS (SELECT 1 FROM public."rbhc-table-profiles" WHERE email = NEW.email) THEN
    UPDATE public."rbhc-table-profiles"
    SET 
      user_id = NEW.id,
      first_name = COALESCE(
        first_name, 
        NEW.raw_user_meta_data->>'first_name', -- Manual Signup
        NEW.raw_user_meta_data->>'given_name', -- Google Standard
        NEW.raw_user_meta_data->>'full_name',  -- Google Fallback
        NEW.raw_user_meta_data->>'name',       -- Generic Fallback
        'Friend'
      )
    WHERE email = NEW.email;
  ELSE
    INSERT INTO public."rbhc-table-profiles" (user_id, email, first_name)
    VALUES (
      NEW.id,
      NEW.email,
      COALESCE(
        NEW.raw_user_meta_data->>'first_name',
        NEW.raw_user_meta_data->>'given_name',
        NEW.raw_user_meta_data->>'full_name',
        NEW.raw_user_meta_data->>'name',
        'Friend'
      )
    );
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 2. Add the missing column that your Dashboard is trying to save
ALTER TABLE public."rbhc-table-profiles" 
ADD COLUMN IF NOT EXISTS merch_preferences text[] DEFAULT '{}';

-- 3. Add the missing UPDATE policy so users can save their profile
CREATE POLICY "Users can update their own profile" 
ON public."rbhc-table-profiles" 
FOR UPDATE 
TO authenticated 
USING (auth.uid() = user_id) 
WITH CHECK (auth.uid() = user_id);