-- Update Edge Function trigger payload to include first_name
create or replace function public.call_brevo_sync()
returns trigger
language plpgsql
as $$
declare
  response text;
begin
  select content::text into response
  from http_post(
    'https://dohcquvoxlpqcsdkywbd.functions.supabase.co/sync-brevo-contact',
    json_build_object(
      'email', new.email,
      'tier', new.subscription_tier,
      'first_name', new.first_name
    )::text,
    'application/json',
    json_build_object(
      'Authorization', 'Bearer ' || current_setting('app.settings.service_role_key', true)
    )::text
  );

  return new;
end;
$$;

