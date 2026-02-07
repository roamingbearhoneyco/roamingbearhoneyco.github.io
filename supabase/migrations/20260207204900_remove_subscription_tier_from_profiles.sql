-- Migration: Remove subscription_tier column from rbhc-table-profiles
-- Date: 2025-02-07
-- Purpose: subscription_tier is now managed in subscriptions table, not denormalized in profiles

ALTER TABLE public."rbhc-table-profiles"
DROP COLUMN IF EXISTS subscription_tier;

-- ============================================================================
-- ROLLBACK INSTRUCTIONS
-- ============================================================================
--
-- To rollback this migration:
--
-- ALTER TABLE public."rbhc-table-profiles"
-- ADD COLUMN subscription_tier VARCHAR(50) DEFAULT 'free';
