import { serve } from "std/server";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import Stripe from "stripe";

const stripe = new Stripe(Deno.env.get("STRIPE_SECRET_KEY")!, {
  httpClient: Stripe.createFetchHttpClient(),
});

const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
);

serve(async (req) => {
  const signature = req.headers.get("stripe-signature");
  const body = await req.text();

  try {
    // 1. Verify the event actually came from Stripe
    const event = stripe.webhooks.constructEvent(
      body,
      signature!,
      Deno.env.get("STRIPE_WEBHOOK_SECRET")!
    );

    console.log(`🔔 Event Received: ${event.type}`);

    switch (event.type) {
      
      // CASE 1: INITIAL PURCHASE
      case "checkout.session.completed": {
        const session = event.data.object as Stripe.Checkout.Session;
        const { profile_id, tier_id, billing_cycle } = session.metadata!;
        
        const subscription = await stripe.subscriptions.retrieve(session.subscription as string);
        const nextRenewal = new Date(subscription.current_period_end * 1000).toISOString();

        const { error } = await supabase.from("subscriptions").update({
          tier_id: parseInt(tier_id),
          billing_cycle: parseInt(billing_cycle),
          stripe_customer_id: session.customer as string,
          stripe_subscription_id: session.subscription as string,
          status: subscription.status, // "active"
          next_renewal_date: nextRenewal,
          updated_at: new Date().toISOString(),
        }).eq("profile_id", profile_id);

        if (error) throw error;
        console.log(`✅ Subscription Created for Profile: ${profile_id}`);
        break;
      }

      // CASE 2: SUCCESSFUL RENEWAL (Every 1, 6, or 12 months)
      case "invoice.paid": {
        const invoice = event.data.object as Stripe.Invoice;
        // Skip if this isn't a subscription invoice
        if (!invoice.subscription) break;

        const subscription = await stripe.subscriptions.retrieve(invoice.subscription as string);
        const nextRenewal = new Date(subscription.current_period_end * 1000).toISOString();

        const { error } = await supabase.from("subscriptions").update({
          status: "active",
          next_renewal_date: nextRenewal,
          updated_at: new Date().toISOString(),
        }).eq("stripe_subscription_id", invoice.subscription);

        if (error) throw error;
        console.log(`✅ Renewal Processed for Subscription: ${invoice.subscription}`);
        break;
      }

      // CASE 3: PAYMENT FAILED
      case "invoice.payment_failed": {
        const invoice = event.data.object as Stripe.Invoice;
        await supabase.from("subscriptions").update({
          status: "past_due",
          updated_at: new Date().toISOString(),
        }).eq("stripe_subscription_id", invoice.subscription);

        console.log(`⚠️ Payment Failed for Subscription: ${invoice.subscription}`);
        break;
      }

      // CASE 4: CANCELLATION OR MODIFICATION
      case "customer.subscription.deleted":
      case "customer.subscription.updated": {
        const sub = event.data.object as Stripe.Subscription;
        await supabase.from("subscriptions").update({
          status: sub.status,
          updated_at: new Date().toISOString(),
        }).eq("stripe_subscription_id", sub.id);

        console.log(`ℹ️ Subscription ${sub.id} status updated to: ${sub.status}`);
        break;
      }

      default:
        console.log(`Unhandled event type ${event.type}`);
    }

    return new Response(JSON.stringify({ received: true }), { status: 200 });
  } catch (err) {
    console.error(`❌ Webhook Error: ${err.message}`);
    return new Response(`Webhook Error: ${err.message}`, { status: 400 });
  }
});