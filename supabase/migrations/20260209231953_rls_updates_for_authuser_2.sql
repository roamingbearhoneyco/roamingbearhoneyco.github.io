DROP POLICY IF EXISTS "Allow onboarding submission" ON public."rbhc-table-profiles";

CREATE POLICY "Allow onboarding submission" 
ON public."rbhc-table-profiles" 
FOR INSERT 
TO anon, authenticated 
WITH CHECK (
  -- We allow the insert if an email is provided. 
  -- Our Gatekeeper Trigger will handle the "is it a duplicate?" logic.
  email IS NOT NULL 
);