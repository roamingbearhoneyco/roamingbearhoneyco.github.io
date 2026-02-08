CREATE OR REPLACE FUNCTION public.handle_new_auth_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  IF EXISTS (SELECT 1 FROM public."rbhc-table-profiles" WHERE email = NEW.email) THEN
    UPDATE public."rbhc-table-profiles"
    SET 
      user_id = NEW.id,
      -- Extract first word from full_name if first_name is missing
      first_name = COALESCE(
        first_name, 
        NEW.raw_user_meta_data->>'first_name',
        split_part(NEW.raw_user_meta_data->>'full_name', ' ', 1),
        split_part(NEW.raw_user_meta_data->>'name', ' ', 1)
      )
    WHERE email = NEW.email;
  ELSE
    INSERT INTO public."rbhc-table-profiles" (user_id, email, first_name)
    VALUES (
      NEW.id,
      NEW.email,
      COALESCE(
        NEW.raw_user_meta_data->>'first_name',
        split_part(NEW.raw_user_meta_data->>'full_name', ' ', 1),
        split_part(NEW.raw_user_meta_data->>'name', ' ', 1)
      )
    );
  END IF;
  RETURN NEW;
END;
$$;