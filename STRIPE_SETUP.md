# Stripe Integration Setup Guide

## Overview

This guide walks you through setting up Stripe for development and production environments for the Roaming Bear Honey Co. subscription system.

## Architecture

The integration uses two Supabase Edge Functions to keep all Stripe secrets isolated from your Astro frontend:

1. **create-checkout-session** (Edge Function)
   - Called by `/api/checkout` endpoint
   - Uses `STRIPE_SECRET_KEY` from Supabase Vault
   - Creates Stripe checkout sessions
   - Returns checkout URL

2. **stripe-webhooks** (Edge Function)
   - Receives events from Stripe
   - Uses `STRIPE_WEBHOOK_SECRET` from Supabase Vault
   - Updates database with subscription details

**Why?** Stripe secrets only exist in Supabase Vault—never in your codebase or Astro endpoint.

## Prerequisites

- Stripe account (create at https://dashboard.stripe.com)
- Supabase project set up and running
- Node.js and npm installed locally

## Step 1: Create Stripe Account

1. Go to [Stripe Dashboard](https://dashboard.stripe.com)
2. Sign up or log in with roamingbearhoneyco@gmail.com
3. Complete account setup (business details)
4. Enable test mode (toggle in top-left corners)

## Step 2: Get API Keys (Development/Test Mode)

### In Stripe Dashboard:

1. Navigate to **Developers** → **API Keys**
2. Ensure you're in **Test Mode** (toggle at top-left)
3. Copy the **Secret Key** - starts with `sk_test_` (⚠️ SECRET - next step)

**Note:** You don't need the Publishable Key for this setup since we use Stripe-hosted checkout (no client-side form).

### In Your Project:

Create `.env.local` in the project root:

```env
# Site URL for redirect
SITE_URL=http://localhost:3000
```

⚠️ **IMPORTANT**: Do NOT add `STRIPE_SECRET_KEY` or `STRIPE_WEBHOOK_SECRET` to `.env.local`!
These go to Supabase Vault (see Step 4 below).

## Step 3: Create Webhook Endpoint

1. Deploy your Supabase edge function (see **Deployment** section below)
2. In Stripe Dashboard, go to **Developers** → **Webhooks**
3. Click **Add Endpoint**
4. Enter your webhook URL:
   ```
   https://<your-project>.supabase.co/functions/v1/stripe-webhooks
   ```
5. Select events to listen for:
   - `checkout.session.completed`
   - `customer.subscription.updated`
   - `customer.subscription.deleted`
6. Copy the **Signing Secret** (starts with `whsec_`) - ⚠️ KEEP PRIVATE
7. Do NOT add to `.env.local` - see Step 4 to add it to Supabase Vault

## Step 4: Configure Supabase Secrets (Server-Side Only)

These secrets are ONLY needed on the server (Edge Functions), not in your local code.

### Via Supabase CLI (Recommended):

```bash
# Add both secrets to Supabase Vault
supabase secrets set STRIPE_SECRET_KEY=sk_test_your_secret_key_here
supabase secrets set STRIPE_WEBHOOK_SECRET=whsec_your_webhook_secret_here
```

When you run `supabase functions serve` locally, these secrets are automatically injected into your functions' environment.

### Via Supabase Dashboard (Alternative):

1. Go to **Settings** → **Vault** 
2. Add new secrets:
   - Key: `STRIPE_SECRET_KEY` → Value: your `sk_test_` key
   - Key: `STRIPE_WEBHOOK_SECRET` → Value: your `whsec_` key

**Why?** These secrets are never needed on the frontend and should NEVER be committed to git. Storing them in Supabase Vault keeps them secure and separate from your codebase.

## Step 5: Deploy Supabase Edge Functions

```bash
# From project root, deploy both functions:
npx supabase functions deploy stripe-webhooks
npx supabase functions deploy create-checkout-session
```

The two functions handle:
- **create-checkout-session** - Creates Stripe checkout sessions (called by `/api/checkout`)
- **stripe-webhooks** - Handles Stripe webhook events and syncs to database

Verify logs:
```bash
npx supabase functions logs stripe-webhooks --tail
npx supabase functions logs create-checkout-session --tail
```

## Step 6: Test with Stripe Test Card

Use Stripe's test card details to simulate payments:

**Successful Payment:**
- Card: `4242 4242 4242 4242`
- Expiry: Any future date (e.g., 12/25)
- CVC: Any 3 digits (e.g., 123)

**Failed Payment:**
- Card: `4000 0000 0000 0002`

## Step 7: Verify Database Updates

After a successful test payment:

1. Go to Supabase Dashboard → SQL Editor
2. Run this query to verify the subscription was updated:

```sql
SELECT id, profile_id, tier_id, stripe_customer_id, stripe_subscription_id, status, next_renewal_date
FROM subscriptions
ORDER BY created_at DESC
LIMIT 5;
```

You should see:
- `stripe_customer_id` populated (cus_xxx)
- `stripe_subscription_id` populated (sub_xxx)
- `status` = 'active'
- `next_renewal_date` set to future date

## Step 8: Test the Full Flow

1. Start dev server: `npm run dev`
2. Go to `/portal` → **Upgrade Tier**
3. Select a paid tier and billing cycle
4. Click **Select Plan**
5. Enter test card `4242 4242 4242 4242`
6. Complete checkout
7. You should be redirected to success page
8. Verify database was updated (see Step 7)

## Webhook Debugging

### View Webhook Events in Stripe

1. Stripe Dashboard → **Developers** → **Webhooks**
2. Click on your endpoint
3. View **Events** to see recent webhook calls
4. Click event to see full payload and response status

### View Edge Function Logs

```bash
npx supabase functions logs stripe-webhooks --tail
```

## Environment Variables Summary

| Variable | Where | Purpose | Safe to Commit? |
|----------|-------|---------|-----------------|
| `STRIPE_SECRET_KEY` | Supabase Vault only | Server authentication with Stripe | ❌ No (secret) |
| `STRIPE_WEBHOOK_SECRET` | Supabase Vault only | Verify webhook signatures | ❌ No (secret) |
| `SITE_URL` | `.env.local` | Redirect URLs after checkout | ✅ Yes |

**Note:** `STRIPE_PUBLISHABLE_KEY` is NOT needed for our setup (Stripe-hosted checkout)

## Production Deployment

When moving to production:

1. **In Stripe Dashboard:**
   - Disable test mode toggle
   - Copy **Live** API keys (start with `pk_live_` and `sk_live_`)

2. **In Your .env:**
   ```env
   STRIPE_SECRET_KEY=sk_live_your_live_secret_key
   STRIPE_WEBHOOK_SECRET=whsec_your_live_webhook_secret
   ```

3. **In Supabase Vault:**
   - Update to live keys

4. **Webhook Endpoint:**
   - Create new webhook endpoint for live mode
   - Update in Stripe Dashboard

## Troubleshooting

### Issue: Webhook events not triggering

**Solution:**
1. Verify webhook endpoint URL is correct and accessible
2. Check Stripe Dashboard → Developers → Webhooks for failed deliveries
3. Verify `STRIPE_WEBHOOK_SECRET` is set correctly in Supabase
4. Check edge function logs: `supabase functions logs stripe-webhooks --tail`

### Issue: Checkout returns error

**Solution:**
1. Verify `STRIPE_SECRET_KEY` is set in `.env.local`
2. Check API endpoint logs for errors
3. Ensure tier_id is valid in database
4. Test with curl:
   ```bash
   curl -X POST http://localhost:3000/api/checkout \
     -H "Authorization: Bearer YOUR_AUTH_TOKEN" \
     -H "Content-Type: application/json" \
     -d '{"tier_id": 2, "billing_cycle": 1}'
   ```

### Issue: Database not updating after payment

**Solution:**
1. Verify Supabase RLS policies allow edge function to write
2. Check `STRIPE_WEBHOOK_SECRET` in Supabase matches Stripe Dashboard
3. View webhook event details in Stripe Dashboard to see response
4. Enable SQL query logging in Supabase to debug INSERT/UPDATE

## Next Steps

- [ ] Set up landing page with checkout button
- [ ] Implement subscription management (pause, cancel, upgrade)
- [ ] Set up billing portal for customers
- [ ] Add email notifications for subscription events
- [ ] Configure Stripe email receipts

## Support

For issues:
1. Check Stripe Dashboard → Developers → Webhooks for event details
2. View edge function logs via Supabase
3. Refer to [Stripe API Docs](https://stripe.com/docs/api)
4. Check [Supabase Edge Functions Docs](https://supabase.com/docs/guides/functions)
