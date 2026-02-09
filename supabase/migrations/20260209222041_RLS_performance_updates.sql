-- 1. Optimized Policy for public.subscriptions
DROP POLICY IF EXISTS "Users can view their own subscription" ON public.subscriptions;
CREATE POLICY "Users can view their own subscription" 
ON public.subscriptions 
FOR SELECT 
TO authenticated 
USING (profile_id IN (SELECT id FROM public."rbhc-table-profiles" WHERE user_id = (SELECT auth.uid())));

-- 2. Optimized Policy for public.orders
DROP POLICY IF EXISTS "Users can view their own orders" ON public.orders;
CREATE POLICY "Users can view their own orders" 
ON public.orders 
FOR SELECT 
TO authenticated 
USING (profile_id IN (SELECT id FROM public."rbhc-table-profiles" WHERE user_id = (SELECT auth.uid())));

-- 3. Optimized Policy for public.order_items
-- This assumes order_items are linked via an order_id to the orders table
DROP POLICY IF EXISTS "Users can view order items for their orders" ON public.order_items;
CREATE POLICY "Users can view order items for their orders" 
ON public.order_items 
FOR SELECT 
TO authenticated 
USING (
  order_id IN (
    SELECT id FROM public.orders WHERE profile_id IN (
      SELECT id FROM public."rbhc-table-profiles" WHERE user_id = (SELECT auth.uid())
    )
  )
);

-- 4. Optimized Policy for public."rbhc-table-profiles"
-- Specifically fixing the UPDATE policy mentioned in your log
DROP POLICY IF EXISTS "Users can update their own profile" ON public."rbhc-table-profiles";
CREATE POLICY "Users can update their own profile" 
ON public."rbhc-table-profiles" 
FOR UPDATE 
TO authenticated 
USING (user_id = (SELECT auth.uid()))
WITH CHECK (user_id = (SELECT auth.uid()));

-- Also optimize the SELECT policy for profiles while we are at it
DROP POLICY IF EXISTS "Users can view own profile" ON public."rbhc-table-profiles";
CREATE POLICY "Users can view own profile" 
ON public."rbhc-table-profiles" 
FOR SELECT 
TO authenticated 
USING (user_id = (SELECT auth.uid()));