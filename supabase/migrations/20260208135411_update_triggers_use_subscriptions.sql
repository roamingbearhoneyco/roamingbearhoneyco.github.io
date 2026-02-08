-- Update the sync function to fetch the Tier Name properly
CREATE OR REPLACE FUNCTION public.sync_subscription_to_brevo() 
RETURNS trigger 
LANGUAGE plpgsql SECURITY DEFINER
SET search_path TO 'public', 'extensions'
AS $$
DECLARE
  res extensions.http_response;
  response_json jsonb;
  v_brevo_id text;
  v_payload JSONB;
  v_service_key TEXT;
BEGIN
  -- 1. Gather rich data (Email, Name, Tier Name)
  SELECT jsonb_build_object(
    'email', p.email,
    'first_name', COALESCE(p.first_name, 'Friend'),
    'tier', st.name
  ) INTO v_payload
  FROM public."rbhc-table-profiles" p
  JOIN public.subscription_tiers st ON st.id = NEW.tier_id
  WHERE p.id = NEW.profile_id;

  -- 2. Get service key from vault
  SELECT decrypted_secret INTO v_service_key 
  FROM vault.decrypted_secrets 
  WHERE name = 'service_role_key';

  -- 3. Call the Edge Function
  res := extensions.http_post(
    'https://your-project.supabase.co/functions/v1/sync-brevo',
    v_payload::text,
    'application/json',
    ARRAY[extensions.http_header('Authorization', 'Bearer ' || v_service_key)]
  );

  -- 4. Parse response: only update if we got a NEW ID (Status 201)
  IF res.status = 201 THEN
    response_json := res.content::jsonb;
    v_brevo_id := response_json->>'brevo_contact_id';

    UPDATE public."rbhc-table-profiles"
    SET brevo_id = v_brevo_id,
        last_synced = NOW()
    WHERE id = NEW.profile_id;
  END IF;

  RETURN NEW;
END;
$$;

-- Apply trigger to subscriptions table
DROP TRIGGER IF EXISTS on_subscription_created_sync ON public.subscriptions;
CREATE TRIGGER on_subscription_created_sync
  AFTER INSERT ON public.subscriptions
  FOR EACH ROW EXECUTE FUNCTION public.sync_subscription_to_brevo();