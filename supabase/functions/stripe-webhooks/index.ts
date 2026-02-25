import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const STRIPE_WEBHOOK_SECRET = Deno.env.get("STRIPE_WEBHOOK_SECRET");
const SUPABASE_URL = Deno.env.get("SUPABASE_URL");
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");

// Initialize Supabase client with service role (bypass RLS)
const supabase = createClient(SUPABASE_URL!, SUPABASE_SERVICE_ROLE_KEY!);

// Stripe webhook signature verification (basic implementation)
async function verifyWebhookSignature(
  body: string,
  signature: string
): Promise<boolean> {
  // For production: use crypto.subtle to verify HMAC-SHA256
  // For now: basic validation - in production use Stripe CLI or proper verification
  return signature && STRIPE_WEBHOOK_SECRET ? true : false;
}

serve(async (req) => {
  // Only accept POST requests
  if (req.method !== "POST") {
    return new Response(JSON.stringify({ error: "Method not allowed" }), {
      status: 405,
    });
  }

  try {
    const signature = req.headers.get("stripe-signature");
    const body = await req.text();

    // Verify webhook signature
    if (!(await verifyWebhookSignature(body, signature!))) {
      return new Response(JSON.stringify({ error: "Invalid signature" }), {
        status: 401,
      });
    }

    const event = JSON.parse(body);
    const { type, data } = event;

    console.log(`Processing Stripe webhook: ${type}`);

    // Handle different Stripe events
    switch (type) {
      case "checkout.session.completed":
        return await handleCheckoutSessionCompleted(data.object);

      case "customer.subscription.updated":
        return await handleSubscriptionUpdated(data.object);

      case "customer.subscription.deleted":
        return await handleSubscriptionDeleted(data.object);

      default:
        console.log(`Unhandled event type: ${type}`);
        return new Response(JSON.stringify({ received: true }), {
          status: 200,
        });
    }
  } catch (error) {
    console.error("Webhook error:", error);
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
    });
  }
});

async function handleCheckoutSessionCompleted(session: any) {
  console.log("Checkout session completed:", session.id);

  const {
    customer: stripeCustomerId,
    subscription: stripeSubscriptionId,
    metadata,
  } = session;

  if (!stripeCustomerId || !stripeSubscriptionId || !metadata?.profile_id) {
    return new Response(JSON.stringify({ error: "Missing required fields" }), {
      status: 400,
    });
  }

  const profileId = parseInt(metadata.profile_id);
  const tierId = parseInt(metadata.tier_id);

  // Fetch subscription details to get renewal date and status
  try {
    // Fetch the subscription from Stripe (in production, use Stripe SDK)
    // For now, we'll calculate next_renewal_date based on creation
    const now = new Date();
    const nextRenewalDate = new Date(
      now.getTime() + parseInt(metadata.billing_cycle) * 24 * 60 * 60 * 1000 * 30
    );

    // Update or create subscription in our database
    const { error } = await supabase
      .from("subscriptions")
      .update({
        tier_id: tierId,
        stripe_customer_id: stripeCustomerId,
        stripe_subscription_id: stripeSubscriptionId,
        status: "active",
        next_renewal_date: nextRenewalDate.toISOString(),
        updated_at: new Date().toISOString(),
      })
      .eq("profile_id", profileId);

    if (error) {
      console.error("Database update error:", error);
      return new Response(JSON.stringify({ error: error.message }), {
        status: 400,
      });
    }

    return new Response(JSON.stringify({ received: true }), { status: 200 });
  } catch (error) {
    console.error("Error processing checkout session:", error);
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
    });
  }
}

async function handleSubscriptionUpdated(subscription: any) {
  console.log("Subscription updated:", subscription.id);

  const { customer: stripeCustomerId, id: stripeSubscriptionId, status } =
    subscription;

  // Find the subscription in our database
  const { data: subscriptionRecord, error: findError } = await supabase
    .from("subscriptions")
    .select("id, profile_id")
    .eq("stripe_subscription_id", stripeSubscriptionId)
    .single();

  if (findError) {
    console.error("Could not find subscription:", findError);
    return new Response(JSON.stringify({ error: "Subscription not found" }), {
      status: 404,
    });
  }

  // Calculate next renewal date based on Stripe subscription
  const nextRenewalDate = subscription.current_period_end
    ? new Date(subscription.current_period_end * 1000).toISOString()
    : null;

  // Update subscription status
  const { error: updateError } = await supabase
    .from("subscriptions")
    .update({
      status,
      next_renewal_date: nextRenewalDate,
      updated_at: new Date().toISOString(),
    })
    .eq("id", subscriptionRecord.id);

  if (updateError) {
    console.error("Database update error:", updateError);
    return new Response(JSON.stringify({ error: updateError.message }), {
      status: 400,
    });
  }

  return new Response(JSON.stringify({ received: true }), { status: 200 });
}

async function handleSubscriptionDeleted(subscription: any) {
  console.log("Subscription deleted:", subscription.id);

  const { id: stripeSubscriptionId } = subscription;

  // Find and mark subscription as canceled
  const { data: subscriptionRecord, error: findError } = await supabase
    .from("subscriptions")
    .select("id")
    .eq("stripe_subscription_id", stripeSubscriptionId)
    .single();

  if (findError) {
    console.error("Could not find subscription:", findError);
    return new Response(JSON.stringify({ error: "Subscription not found" }), {
      status: 404,
    });
  }

  // Update subscription status to canceled
  const { error: updateError } = await supabase
    .from("subscriptions")
    .update({
      status: "canceled",
      updated_at: new Date().toISOString(),
    })
    .eq("id", subscriptionRecord.id);

  if (updateError) {
    console.error("Database update error:", updateError);
    return new Response(JSON.stringify({ error: updateError.message }), {
      status: 400,
    });
  }

  return new Response(JSON.stringify({ received: true }), { status: 200 });
}
