-- 1. Ensure the vault extension is active
CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";

-- 2. Add your secret to the vault
-- Note: Locally, you might use a dummy value, then update it in production
SELECT vault.create_secret(
  'PLACEHOLDER_DO_NOT_COMMIT_REAL_KEY', 
  'service_role_key', 
  'Internal key for triggering Edge Functions'
);