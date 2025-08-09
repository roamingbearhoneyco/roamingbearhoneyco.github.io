create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public."rbhc-table-profiles" (user_id, subscription_tier, created_at)
  values (new.id, 'free', now());
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();
