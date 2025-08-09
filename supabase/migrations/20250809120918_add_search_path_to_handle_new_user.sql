create or replace function public.handle_new_user()
returns TRIGGER as $$
begin
  insert into public."rbhc-table-profiles" (user_id, subscription_tier, created_at)
  values (new.id, 'free', now());
  return new;
end;
$$ language plpgsql security definer SET search_path = 'public, auth';

drop TRIGGER if exists on_auth_user_created on auth.users;

create TRIGGER on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();