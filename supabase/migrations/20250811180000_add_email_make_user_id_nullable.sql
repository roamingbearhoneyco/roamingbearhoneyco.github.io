-- Add email column to rbhc-table-profiles and allow NULL user_id for email-only signups
-- Idempotent-ish guards
do $$
begin
  -- Add column if not exists
  if not exists (
    select 1
    from information_schema.columns
    where table_schema = 'public'
      and table_name = 'rbhc-table-profiles'
      and column_name = 'email'
  ) then
    alter table public."rbhc-table-profiles"
      add column email text;
  end if;

  -- Make user_id nullable if currently not
  if exists (
    select 1 from information_schema.columns
    where table_schema = 'public' and table_name = 'rbhc-table-profiles' and column_name = 'user_id' and is_nullable = 'NO'
  ) then
    alter table public."rbhc-table-profiles"
      alter column user_id drop not null;
  end if;
end $$;

-- Optional: basic check to avoid empty strings
alter table public."rbhc-table-profiles"
  add constraint rbhc_table_profiles_email_not_blank
  check (email is null or length(btrim(email)) > 0);

-- Optional: ensure no duplicate emails if desired (comment out if duplicates allowed)
-- create unique index concurrently if not exists cannot be used in a transaction block
-- Using a conditional execute
do $$
begin
  if not exists (
    select 1 from pg_indexes where schemaname = 'public' and indexname = 'rbhc_table_profiles_email_unique'
  ) then
    execute 'create unique index rbhc_table_profiles_email_unique on public."rbhc-table-profiles" (lower(email)) where email is not null';
  end if;
end $$;

-- Enable RLS (safe to run even if already enabled)
alter table public."rbhc-table-profiles" enable row level security;

-- Policy: allow anon to insert email-only leads
do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'public'
      and tablename = 'rbhc-table-profiles'
      and policyname = 'allow_anon_insert_email'
  ) then
    execute $$
      create policy allow_anon_insert_email
      on public."rbhc-table-profiles"
      for insert
      to anon
      with check (
        auth.role() = 'anon'
        and user_id is null
        and email is not null
        and length(btrim(email)) > 0
      );
    $$;
  end if;
end $$;

-- Grant minimal privileges to anon (insert only; selection handled via server-side if needed)
grant insert on public."rbhc-table-profiles" to anon;

