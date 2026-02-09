CREATE OR REPLACE FUNCTION public.create_subscription_for_new_profile()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 -- This line fixes the warning
 SET search_path TO 'public', 'extensions'
AS $$
BEGIN
  INSERT INTO public.subscriptions (profile_id, tier_id, status)
  VALUES (NEW.id, 1, 'active');
  RETURN NEW;
END;
$$;