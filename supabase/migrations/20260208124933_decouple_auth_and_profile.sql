-- 1. START TRANSACTION
BEGIN;

-- 2. UNLOCK TABLES (Drop Foreign Keys and Policies first)
-- We do this first so Postgres allows us to drop/modify columns later
ALTER TABLE public.subscriptions DROP CONSTRAINT IF EXISTS subscriptions_user_id_fkey;
ALTER TABLE public.orders DROP CONSTRAINT IF EXISTS orders_user_id_fkey;

DROP POLICY IF EXISTS "Users can view their own subscription" ON public.subscriptions;
DROP POLICY IF EXISTS "Users can update their own subscription" ON public.subscriptions;
DROP POLICY IF EXISTS "Users can view their own orders" ON public.orders;
DROP POLICY IF EXISTS "Users can view order items for their orders" ON public.order_items;

-- 3. REFACTOR THE PROFILES TABLE
-- Drop and recreate ID as BigInt Identity
ALTER TABLE public."rbhc-table-profiles" DROP COLUMN IF EXISTS id;
ALTER TABLE public."rbhc-table-profiles" ADD COLUMN id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY;

-- Fix user_id to be the optional Auth UUID link
ALTER TABLE public."rbhc-table-profiles" ALTER COLUMN user_id DROP NOT NULL;
ALTER TABLE public."rbhc-table-profiles" ALTER COLUMN user_id DROP DEFAULT;

-- 4. UPDATE CHILD TABLES (Subscriptions & Orders)
-- Now that policies are gone, we can safely drop these columns
ALTER TABLE public.subscriptions DROP COLUMN IF EXISTS user_id;
ALTER TABLE public.subscriptions DROP COLUMN IF EXISTS profile_id; -- Safety check
ALTER TABLE public.subscriptions ADD COLUMN profile_id BIGINT;

ALTER TABLE public.orders DROP COLUMN IF EXISTS user_id;
ALTER TABLE public.orders DROP COLUMN IF EXISTS profile_id; -- Safety check
ALTER TABLE public.orders ADD COLUMN profile_id BIGINT;

-- 5. RE-ESTABLISH INTEGRITY & SECURITY

-- A) Add Foreign Keys
ALTER TABLE public.subscriptions 
  ADD CONSTRAINT subscriptions_profile_id_fkey 
  FOREIGN KEY (profile_id) REFERENCES public."rbhc-table-profiles"(id) ON DELETE CASCADE;

ALTER TABLE public.orders 
  ADD CONSTRAINT orders_profile_id_fkey 
  FOREIGN KEY (profile_id) REFERENCES public."rbhc-table-profiles"(id) ON DELETE CASCADE;

-- B) Re-create Policies (Using the profile_id -> user_id hop)
CREATE POLICY "Users can view their own subscription" ON public.subscriptions
  FOR SELECT USING (
    profile_id IN (SELECT id FROM public."rbhc-table-profiles" WHERE user_id = auth.uid())
  );

CREATE POLICY "Users can view their own orders" ON public.orders
  FOR SELECT USING (
    profile_id IN (SELECT id FROM public."rbhc-table-profiles" WHERE user_id = auth.uid())
  );

CREATE POLICY "Users can view order items for their orders" ON public.order_items
  FOR SELECT USING (
    order_id IN (
      SELECT id FROM public.orders 
      WHERE profile_id IN (SELECT id FROM public."rbhc-table-profiles" WHERE user_id = auth.uid())
    )
  );

-- 6. UPDATE TRIGGER FUNCTIONS

-- Trigger for Auth -> Profiles (Linker)
CREATE OR REPLACE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  INSERT INTO public."rbhc-table-profiles" (user_id, email)
  VALUES (new.id, new.email)
  ON CONFLICT (email) DO UPDATE
  SET user_id = excluded.user_id
  WHERE public."rbhc-table-profiles".user_id IS NULL;
  RETURN new;
END;
$$;

-- Trigger for Profiles -> Subscriptions (Auto-onboard)
CREATE OR REPLACE FUNCTION public.create_subscription_for_new_profile() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  free_tier_id BIGINT;
BEGIN
  SELECT id INTO free_tier_id FROM public.subscription_tiers WHERE LOWER(name) = 'free' LIMIT 1;
  
  INSERT INTO public.subscriptions (profile_id, tier_id, billing_cycle, status)
  VALUES (NEW.id, free_tier_id, 1, 'active');
  
  RETURN NEW;
END;
$$;

-- Final Trigger Attachments
DROP TRIGGER IF EXISTS on_profile_created_assign_sub ON public."rbhc-table-profiles";
CREATE TRIGGER on_profile_created_assign_sub
  AFTER INSERT ON public."rbhc-table-profiles"
  FOR EACH ROW EXECUTE FUNCTION public.create_subscription_for_new_profile();

COMMIT;