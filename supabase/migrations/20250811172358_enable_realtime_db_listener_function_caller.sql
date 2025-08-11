-- Enable HTTP extension (needed for http_post)
create extension if not exists http;

-- Create a trigger function that calls the Edge Function
create or replace function public.call_brevo_sync()
returns trigger
language plpgsql
as $$
declare
  response text;
begin
  -- Send HTTP POST to Edge Function
  select content::text into response
  from http_post(
    'https://dohcquvoxlpqcsdkywbd.functions.supabase.co/sync-brevo-contact',
    json_build_object(
      'email', new.email,
      'tier', new.subscription_tier
    )::text,
    'application/json',
    json_build_object(
      'Authorization', 'Bearer ' || current_setting('app.settings.service_role_key', true)
    )::text
  );

  -- Optional: log the response for debugging
  raise notice 'Brevo sync response: %', response;

  return new;
end;
$$;

-- Drop trigger if it exists (for re-deploy safety)
drop trigger if exists on_profile_insert on public."rbhc-table-profiles";

-- Create the trigger
create trigger on_profile_insert
after insert on public."rbhc-table-profiles"
for each row execute function public.call_brevo_sync();
