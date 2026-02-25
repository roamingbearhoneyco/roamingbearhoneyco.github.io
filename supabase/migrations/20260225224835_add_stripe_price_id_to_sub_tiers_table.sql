-- Migration: Add Stripe Integration Columns to subscription_tiers
ALTER TABLE public.subscription_tiers 
ADD COLUMN IF NOT EXISTS stripe_product_id TEXT,
ADD COLUMN IF NOT EXISTS stripe_price_id_monthly TEXT,
ADD COLUMN IF NOT EXISTS stripe_price_id_6month TEXT,
ADD COLUMN IF NOT EXISTS stripe_price_id_yearly TEXT;

-- Add a comment for documentation
COMMENT ON COLUMN subscription_tiers.stripe_product_id IS 'The Stripe Product ID (e.g., prod_...)';

-- Optional: Add a check to ensure we don't accidentally put Stripe IDs on the free tier
-- This is just a safeguard; you can skip it if you want more flexibility later.
ALTER TABLE public.subscription_tiers
ADD CONSTRAINT check_stripe_ids_non_free
CHECK (
  (id = 1 AND stripe_product_id IS NULL) OR (id > 1)
);