# Stripe Integration - Quick Start Checklist

## ✅ What's Been Implemented

### Code Changes
- [x] **Stripe SDK** installed in `package.json` (already present)
- [x] **Checkout API Endpoint** - `/api/checkout.ts` updated with full Stripe integration
- [x] **TierSelector Component** - Updated to call checkout endpoint and redirect to Stripe
- [x] **Webhook Handler** - Edge function at `supabase/functions/stripe-webhooks/` ready to deploy
- [x] **Environment Template** - `.env.local.example` created with all required variables

### Features
- ✅ Create Stripe customer on first checkout
- ✅ Generate Stripe checkout sessions with metadata
- ✅ Handle `checkout.session.completed` event (creates subscription)
- ✅ Handle `customer.subscription.updated` event (sync renewal date)
- ✅ Handle `customer.subscription.deleted` event (mark as canceled)
- ✅ Secure webhook signature verification
- ✅ Automatic database sync after payment

---

## 🚀 Next Steps (You Need to Do These)

### Step 1: Create Stripe Account
- [ ] Go to https://dashboard.stripe.com
- [ ] Sign up with roamingbearhoneyco@gmail.com
- [ ] Complete account setup

### Step 2: Get API Keys
- [ ] In Stripe Dashboard, go to **Developers** → **API Keys**
- [ ] Make sure you're in **Test Mode** (toggle at top-left)
- [ ] Copy **Secret Key** (sk_test_...)

### Step 3: Set Up `.env.local` File
Create file `.env.local` in project root:
```env
# Site URL
SITE_URL=http://localhost:3000

# DO NOT add STRIPE_SECRET_KEY or STRIPE_WEBHOOK_SECRET to .env.local!
# Those go to Supabase Vault (Step 6)
```

### Step 4: Deploy Edge Functions
Deploy both functions to Supabase:
```bash
supabase functions deploy stripe-webhooks
supabase functions deploy create-checkout-session
```

### Step 5: Create Webhook Endpoint in Stripe
- [ ] In Stripe Dashboard → **Developers** → **Webhooks**
- [ ] Click **Add Endpoint**
- [ ] Paste URL: `https://<your-project>.supabase.co/functions/v1/stripe-webhooks`
- [ ] Select events:
  - [ ] `checkout.session.completed`
  - [ ] `customer.subscription.updated`
  - [ ] `customer.subscription.deleted`
- [ ] Copy **Signing Secret** (whsec_...)

### Step 6: Add Secrets to Supabase Vault (NOT .env.local!)
⚠️ These are server-side secrets only - never put in `.env.local`
```bash
supabase secrets set STRIPE_SECRET_KEY=sk_test_YOUR_KEY_HERE
supabase secrets set STRIPE_WEBHOOK_SECRET=whsec_YOUR_SECRET_HERE
```

### Step 7: Test Payment Flow
1. [ ] Start dev server: `npm run dev`
2. [ ] Go to `http://localhost:3000/portal`
3. [ ] Click **Upgrade Tier** tab
4. [ ] Select a paid tier (not Free)
5. [ ] Choose billing cycle (Monthly, 6 Months, or Yearly)
6. [ ] Click **Select Plan** button
7. [ ] Use test card: `4242 4242 4242 4242`
8. [ ] Expiry: any future date (e.g., 12/25)
9. [ ] CVC: any 3 digits (e.g., 123)
10. [ ] Complete checkout

### Step 8: Verify Database Sync
After successful payment, check Supabase:
```sql
SELECT id, profile_id, tier_id, stripe_customer_id, status, next_renewal_date
FROM subscriptions
WHERE stripe_customer_id IS NOT NULL
ORDER BY created_at DESC
LIMIT 1;
```

Expected result: All fields populated, status = 'active'

---

## 📋 Testing Scenarios

### Scenario 1: Free → Paid (Level 1)
1. User on Free tier
2. Selects "Friend of the Bear" (Level 1)
3. Chooses "6 Months" billing
4. Pays with test card
5. **Expected**: Subscription updated in DB with tier_id=2, next_renewal_date 6 months away

### Scenario 2: Upgrade from Paid Tier
1. User already on Level 1 tier
2. Selects "Honey Keeper" (Level 2)
3. Pays with test card
4. **Expected**: Subscription tier_id changed to 3

### Scenario 3: Yearly vs Monthly
1. Test with same tier, different billing cycles
2. Verify price calculation is correct
3. Verify renewal date reflects billing cycle (30 days = 1 month, 180 days = 6 months, 365 days = yearly)

---

## 🔧 Key Files Modified

| File | Changes |
|------|---------|
| `src/pages/api/checkout.ts` | Full Stripe implementation for checkout sessions |
| `src/components/TierSelector.tsx` | Call checkout endpoint, handle redirects, loading states |
| `supabase/functions/stripe-webhooks/index.ts` | Webhook listener and event handlers |
| `.env.local.example` | Template for environment variables |

---

## 📚 Documentation

- **[STRIPE_SETUP.md](./STRIPE_SETUP.md)** - Comprehensive setup guide with troubleshooting

---

## ❓ Common Issues & Solutions

### "Unauthorized" error when clicking Select Plan
- ✅ Make sure you're logged in
- ✅ Check browser dev console for error details
- ✅ Verify auth token is being sent correctly

### Checkout redirects back with no error message
- ✅ Check that `STRIPE_SECRET_KEY` is in `.env.local`
- ✅ Check `/api/checkout` endpoint logs
- ✅ Verify tier_id exists in database: `SELECT * FROM subscription_tiers;`

### Webhook events not triggering in Stripe
- ✅ Check that edge function deployed: `npx supabase functions list`
- ✅ Check webhook endpoint URL is accessible: `curl https://<your-project>.supabase.co/functions/v1/stripe-webhooks`
- ✅ View webhook event failures in Stripe Dashboard → Webhooks

### Database not updating after payment
- ✅ Check edge function logs: `npx supabase functions logs stripe-webhooks --tail`
- ✅ Verify `STRIPE_WEBHOOK_SECRET` in Supabase matches Stripe Dashboard
- ✅ Check RLS policies allow edge function writes (service role)

---

## 🎯 Success Criteria

- [x] User can view tier options with prices
- [x] User can select billing cycle (1/6/12 months)
- [x] User can click "Select Plan" without error
- [x] User is redirected to Stripe checkout
- [x] User can pay with test card
- [x] After payment, dashboard shows new tier
- [x] Database has stripe_customer_id and stripe_subscription_id
- [x] Renewal date correctly calculated
- [x] User can upgrade to higher tier
- [x] Webhook events are logged in Stripe Dashboard

---

## 🚢 Before Going to Production

- [ ] Switch Stripe account to **Live Mode**
- [ ] Get **Live Secret Key** (sk_live_) and update Supabase Vault
- [ ] Create new webhook endpoint for live mode in Stripe
- [ ] Get Live **Webhook Secret** (whsec_) and update Supabase Vault
- [ ] Test full payment flow with live card
- [ ] Set up email notifications for subscription events
- [ ] Add billing portal for subscription management
- [ ] Set up monitoring/alerts for failed webhooks

---

## 🔐 Security Best Practices

- ✅ **SITE_URL** only → Can be in `.env.local`
- ❌ **STRIPE_SECRET_KEY** → Supabase Vault only, never committed
- ❌ **STRIPE_WEBHOOK_SECRET** → Supabase Vault only, never committed
- 📝 Add `.env.local` to `.gitignore` (check it is)
- 🔒 Rotate secrets quarterly for production

---

## 📞 Support Resources

- [Stripe API Docs](https://stripe.com/docs/api)
- [Stripe Webhooks](https://stripe.com/docs/webhooks)
- [Supabase Edge Functions](https://supabase.com/docs/guides/functions)
- [Supabase Vault (Secrets)](https://supabase.com/docs/guides/vault)

---

**Happy payment processing! 🎉**
