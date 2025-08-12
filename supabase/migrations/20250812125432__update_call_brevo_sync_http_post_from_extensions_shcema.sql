CREATE OR REPLACE FUNCTION public.call_brevo_sync()
RETURNS trigger AS
$$
DECLARE
  res extensions.http_response;
  response_json jsonb;
  brevo_id text;
BEGIN
  -- Make sure to qualify http_post with extensions schema
  res := extensions.http_post(
    'https://dohcquvoxlpqcsdkywbd.functions.supabase.co/sync-brevo-contact',
    json_build_object(
      'email', NEW.email,
      'tier', NEW.subscription_tier,
      'first_name', NEW.first_name
    )::text,
    'application/json'
  );

  response_json := res.content::jsonb;

  brevo_id := response_json->>'brevo_contact_id';

  IF brevo_id IS NOT NULL THEN
    UPDATE public."rbhc-table-profiles"
    SET brevo_contact_id = brevo_id,
        last_synced = NOW()
    WHERE id = NEW.id;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER
  SET search_path = public, extensions;
