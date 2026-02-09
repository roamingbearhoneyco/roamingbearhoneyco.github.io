DROP POLICY IF EXISTS "Allow insert for email-only subscribers" ON public."rbhc-table-profiles";

CREATE POLICY "Allow onboarding submission" 
ON public."rbhc-table-profiles" 
FOR INSERT 
TO anon, authenticated 
WITH CHECK (
  -- This allows the insert to reach the Trigger/Gatekeeper
  -- where your logic will then decide to UPDATE, FAIL, or PROCEED.
  true 
);