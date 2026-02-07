-- Migration: Create subscription system tables
-- Date: 2025-02-07
-- Purpose: Single source of truth for all user tiers (free, level-1, level-2, level-3)
--          with Stripe integration and flexible billing cycles

-- ============================================================================
-- TABLE: subscription_tiers
-- Purpose: Define tier details (benefits, names, prices)
-- ============================================================================
CREATE TABLE public.subscription_tiers (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE, -- 'free', 'level-1', 'level-2', 'level-3'
  display_name VARCHAR(100) NOT NULL, -- 'Free', 'Level 1: Friend of the Bear', etc.
  description TEXT,
  
  -- Pricing per billing cycle (in cents, e.g., 900 = $9.00)
  price_monthly INT NOT NULL DEFAULT 0, -- $0 for free, actual price for paid tiers
  price_6month INT NOT NULL DEFAULT 0,
  price_yearly INT NOT NULL DEFAULT 0,
  
  -- Benefits (stored as JSON for flexibility)
  benefits JSONB DEFAULT '{}', -- e.g., {"honey_jars_per_year": 1, "discount_percent": 5}
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Pre-populate tiers
INSERT INTO public.subscription_tiers 
  (name, display_name, description, price_monthly, price_6month, price_yearly, benefits)
VALUES
  ('free', 'Free', 'Access to content and community', 0, 0, 0, '{"honey_jars_per_year": 0, "discount_percent": 0, "merchandise": []}'),
  ('level-1', 'Level 1: Friend of the Bear', '1 jar of honey per year + merch', 1299, 7794, 12990, '{"honey_jars_per_year": 1, "discount_percent": 0, "merchandise": ["shirt", "hat"]}'),
  ('level-2', 'Level 2: Honey Keeper', '1 jar + shirt/hat + 5% discount', 1799, 10794, 17990, '{"honey_jars_per_year": 1, "discount_percent": 5, "merchandise": ["shirt", "hat"]}'),
  ('level-3', 'Level 3: Bear Guardian', '2 jars per year (spring/fall) + merch + 10% discount', 2499, 14994, 24990, '{"honey_jars_per_year": 2, "discount_percent": 10, "merchandise": ["shirt", "hat", "other"]}');

-- Index for lookups
CREATE INDEX idx_subscription_tiers_name ON public.subscription_tiers(name);

-- ============================================================================
-- TABLE: subscriptions
-- Purpose: Track each user's subscription (single source of truth for tier)
-- ============================================================================
CREATE TABLE public.subscriptions (
  id BIGSERIAL PRIMARY KEY,
  user_id UUID NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
  
  -- Tier reference
  tier_id BIGINT NOT NULL REFERENCES public.subscription_tiers(id),
  
  -- Stripe integration
  stripe_customer_id VARCHAR(255), -- null until first payment
  stripe_subscription_id VARCHAR(255), -- null until Stripe subscription created
  
  -- Billing cycle in months
  billing_cycle INT NOT NULL DEFAULT 1, -- 1, 6, or 12
  
  -- Subscription status
  status VARCHAR(50) NOT NULL DEFAULT 'active', -- active, paused, canceled
  
  -- Renewal tracking
  next_renewal_date TIMESTAMP WITH TIME ZONE,
  
  -- Timestamps
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for common queries
CREATE INDEX idx_subscriptions_user_id ON public.subscriptions(user_id);
CREATE INDEX idx_subscriptions_tier_id ON public.subscriptions(tier_id);
CREATE INDEX idx_subscriptions_stripe_customer_id ON public.subscriptions(stripe_customer_id);
CREATE INDEX idx_subscriptions_stripe_subscription_id ON public.subscriptions(stripe_subscription_id);
CREATE INDEX idx_subscriptions_status ON public.subscriptions(status);
CREATE INDEX idx_subscriptions_next_renewal_date ON public.subscriptions(next_renewal_date);

-- ============================================================================
-- TABLE: orders
-- Purpose: Track physical honey shipments and merchandise orders
-- ============================================================================
CREATE TABLE public.orders (
  id BIGSERIAL PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  
  -- Order status
  status VARCHAR(50) NOT NULL DEFAULT 'pending', -- pending, shipped, delivered, canceled
  
  -- Tracking
  tracking_number VARCHAR(255),
  
  -- Timestamps
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  shipped_at TIMESTAMP WITH TIME ZONE,
  delivered_at TIMESTAMP WITH TIME ZONE,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_orders_user_id ON public.orders(user_id);
CREATE INDEX idx_orders_status ON public.orders(status);
CREATE INDEX idx_orders_created_at ON public.orders(created_at);

-- ============================================================================
-- TABLE: products
-- Purpose: Honey jars, shirts, hats, merch items
-- ============================================================================
CREATE TABLE public.products (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  type VARCHAR(50) NOT NULL, -- 'honey', 'shirt', 'hat', 'merch'
  description TEXT,
  price INT NOT NULL, -- in cents
  
  -- Dropship info (optional)
  dropship_sku VARCHAR(255),
  dropship_supplier VARCHAR(255),
  
  -- Availability
  is_active BOOLEAN DEFAULT TRUE,
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_products_type ON public.products(type);
CREATE INDEX idx_products_is_active ON public.products(is_active);

-- ============================================================================
-- TABLE: order_items
-- Purpose: Line items in each order
-- ============================================================================
CREATE TABLE public.order_items (
  id BIGSERIAL PRIMARY KEY,
  order_id BIGINT NOT NULL REFERENCES public.orders(id) ON DELETE CASCADE,
  product_id BIGINT NOT NULL REFERENCES public.products(id),
  
  quantity INT NOT NULL DEFAULT 1,
  price_paid INT NOT NULL, -- in cents, for historical record
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_order_items_order_id ON public.order_items(order_id);
CREATE INDEX idx_order_items_product_id ON public.order_items(product_id);

-- ============================================================================
-- RLS POLICIES - Enable Row Level Security
-- ============================================================================

-- Enable RLS on all new tables
ALTER TABLE public.subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY;

-- Subscriptions: authenticated users can only see their own
CREATE POLICY "Users can view their own subscription"
  ON public.subscriptions
  FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own subscription"
  ON public.subscriptions
  FOR UPDATE
  USING (auth.uid() = user_id);

-- Orders: authenticated users can only see their own
CREATE POLICY "Users can view their own orders"
  ON public.orders
  FOR SELECT
  USING (auth.uid() = user_id);

-- Order items: authenticated users can only see items in their orders
CREATE POLICY "Users can view order items for their orders"
  ON public.order_items
  FOR SELECT
  USING (order_id IN (SELECT id FROM public.orders WHERE user_id = auth.uid()));

-- Subscription tiers and products are public read-only
ALTER TABLE public.subscription_tiers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Everyone can view subscription tiers"
  ON public.subscription_tiers
  FOR SELECT
  USING (true);

CREATE POLICY "Everyone can view products"
  ON public.products
  FOR SELECT
  USING (is_active = true);

-- ============================================================================
-- FUNCTION: Auto-create subscription for new users
-- ============================================================================
-- When a new profile is created, auto-create a 'free' subscription
CREATE OR REPLACE FUNCTION public.create_subscription_for_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  free_tier_id BIGINT;
BEGIN
  -- Get the 'free' tier ID
  SELECT id INTO free_tier_id FROM public.subscription_tiers WHERE name = 'free' LIMIT 1;
  
  IF free_tier_id IS NULL THEN
    RAISE LOG 'Free tier not found in subscription_tiers table';
    RETURN NEW;
  END IF;
  
  -- Create subscription for this user only if they don't already have one
  INSERT INTO public.subscriptions (user_id, tier_id, billing_cycle, status)
  VALUES (NEW.user_id, free_tier_id, 1, 'active')
  ON CONFLICT (user_id) DO NOTHING;
  
  RETURN NEW;
END;
$$;

-- Trigger: When profile is created (and user_id is not null), create free subscription
CREATE TRIGGER on_profile_insert_create_subscription
  AFTER INSERT ON public."rbhc-table-profiles"
  FOR EACH ROW
  WHEN (NEW.user_id IS NOT NULL)
  EXECUTE FUNCTION public.create_subscription_for_new_user();

-- ============================================================================
-- ROLLBACK INSTRUCTIONS
-- ============================================================================
--
-- To rollback this migration, run:
--
-- DROP TRIGGER IF EXISTS on_profile_insert_create_subscription ON public."rbhc-table-profiles";
-- DROP FUNCTION IF EXISTS public.create_subscription_for_new_user();
-- DROP TABLE IF EXISTS public.order_items CASCADE;
-- DROP TABLE IF EXISTS public.orders CASCADE;
-- DROP TABLE IF EXISTS public.products CASCADE;
-- DROP TABLE IF EXISTS public.subscriptions CASCADE;
-- DROP TABLE IF EXISTS public.subscription_tiers CASCADE;
--