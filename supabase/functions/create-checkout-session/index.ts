import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

// Stripe SDK for Deno
// Using native fetch to call Stripe API (no SDK needed)

const STRIPE_SECRET_KEY = Deno.env.get("STRIPE_SECRET_KEY");
const SUPABASE_URL = Deno.env.get("SUPABASE_URL");
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
const SITE_URL = Deno.env.get("SITE_URL") || "https://testsite.roamingbearhoneyco.com";

interface CheckoutRequest {
  profile_id: number;
  tier_id: number;
  billing_cycle: number;
  stripe_customer_id?: string;
}

serve(async (req) => {
  // Only POST allowed
  if (req.method !== "POST") {
    return new Response(JSON.stringify({ error: "Method not allowed" }), {
      status: 405,
      headers: { "Content-Type": "application/json" },
    });
  }

  try {
    const { profile_id, tier_id, billing_cycle, stripe_customer_id } =
      (await req.json()) as CheckoutRequest;

    if (!profile_id || !tier_id || !billing_cycle) {
      return new Response(
        JSON.stringify({ error: "Missing required fields" }),
        { status: 400, headers: { "Content-Type": "application/json" } }
      );
    }

    // Initialize Supabase client
    const supabase = createClient(SUPABASE_URL!, SUPABASE_SERVICE_ROLE_KEY!);

    // Fetch tier details
    const { data: tier, error: tierError } = await supabase
      .from("subscription_tiers")
      .select("*")
      .eq("id", tier_id)
      .single();

    if (tierError || !tier) {
      return new Response(JSON.stringify({ error: "Tier not found" }), {
        status: 404,
        headers: { "Content-Type": "application/json" },
      });
    }

    // Calculate price
    const priceInCents =
      billing_cycle === 1
        ? tier.price_monthly
        : billing_cycle === 6
        ? tier.price_6month
        : tier.price_yearly;

    const billingCycleLabel =
      billing_cycle === 1 ? "month" : billing_cycle === 6 ? "6 months" : "year";

    // Call Stripe API to create checkout session
    const stripeResponse = await fetch(
      "https://api.stripe.com/v1/checkout/sessions",
      {
        method: "POST",
        headers: {
          "Authorization": `Bearer ${STRIPE_SECRET_KEY}`,
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: new URLSearchParams({
          "customer": stripe_customer_id || "",
          "payment_method_types[0]": "card",
          "line_items[0][price_data][currency]": "usd",
          "line_items[0][price_data][product_data][name]": `${tier.display_name} - ${billingCycleLabel}`,
          "line_items[0][price_data][product_data][description]":
            tier.description,
          "line_items[0][price_data][product_data][metadata][tier_id]":
            tier.id.toString(),
          "line_items[0][price_data][product_data][metadata][tier_name]":
            tier.name,
          "line_items[0][price_data][unit_amount]": priceInCents.toString(),
          "line_items[0][quantity]": "1",
          "mode": "subscription",
          "success_url": `${SITE_URL}/portal?success=true`,
          "cancel_url": `${SITE_URL}/portal?canceled=true`,
          "metadata[profile_id]": profile_id.toString(),
          "metadata[tier_id]": tier_id.toString(),
          "metadata[billing_cycle]": billing_cycle.toString(),
        }).toString(),
      }
    );

    if (!stripeResponse.ok) {
      const error = await stripeResponse.json();
      console.error("Stripe API error:", error);
      return new Response(JSON.stringify({ error: error.error?.message }),
        {
          status: 400,
          headers: { "Content-Type": "application/json" },
        }
      );
    }

    const session = await stripeResponse.json();

    return new Response(
      JSON.stringify({
        sessionUrl: session.url,
        sessionId: session.id,
      }),
      {
        status: 200,
        headers: { "Content-Type": "application/json" },
      }
    );
  } catch (error) {
    console.error("Checkout error:", error);
    return new Response(
      JSON.stringify({
        error: error instanceof Error ? error.message : "Internal server error",
      }),
      { status: 500, headers: { "Content-Type": "application/json" } }
    );
  }
});
