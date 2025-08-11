-- Migration: Adjust rbhc-table-profiles for email subscriptions and new PK

DO $$
DECLARE
  pk_name text;
BEGIN
  -- Find existing primary key constraint name
  SELECT constraint_name INTO pk_name
  FROM information_schema.table_constraints
  WHERE table_schema = 'public'
    AND table_name = 'rbhc-table-profiles'
    AND constraint_type = 'PRIMARY KEY';

  -- Drop the existing PK constraint if it exists
  IF pk_name IS NOT NULL THEN
    EXECUTE format('ALTER TABLE public."rbhc-table-profiles" DROP CONSTRAINT %I', pk_name);
  END IF;
END;
$$;

-- Add new id column if it doesn't exist
ALTER TABLE public."rbhc-table-profiles"
ADD COLUMN IF NOT EXISTS id bigserial;

-- Set the new id column as primary key
ALTER TABLE public."rbhc-table-profiles"
ADD PRIMARY KEY (id);

-- Make user_id nullable if currently NOT NULL
ALTER TABLE public."rbhc-table-profiles"
ALTER COLUMN user_id DROP NOT NULL;

-- Add email column if it doesn't exist
ALTER TABLE public."rbhc-table-profiles"
ADD COLUMN IF NOT EXISTS email text;

-- Create unique index on email to avoid duplicates
CREATE UNIQUE INDEX IF NOT EXISTS idx_profiles_email ON public."rbhc-table-profiles" (email);
-- 20250811190000_update_handle_new_user_function.sql

create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public."rbhc-table-profiles" (user_id, subscription_tier, created_at, email)
  values (new.id, 'free', now(), new.email)
  on conflict (email) do update
  set user_id = excluded.user_id
  where public."rbhc-table-profiles".user_id is null;

  return new;
end;
$$ language plpgsql security definer SET search_path = 'public, auth';

drop trigger if exists on_auth_user_created on auth.users;

create trigger on_auth_user_created
after insert on auth.users
for each row execute procedure public.handle_new_user();
