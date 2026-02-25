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
  try {
    const { profile_id, tier_id, billing_cycle } = await req.json();

    // 1. Get the tier and its Stripe Price IDs from your DB
    const { data: tier, error: tierError } = await supabase
      .from("subscription_tiers")
      .select("*")
      .eq("id", tier_id)
      .single();

    if (tierError || !tier) throw new Error("Subscription tier not found");

    // 2. Select the correct Price ID based on the cycle
    const stripePriceId = 
      billing_cycle === 1 ? tier.stripe_price_id_monthly :
      billing_cycle === 6 ? tier.stripe_price_id_6month :
      tier.stripe_price_id_yearly;

    if (!stripePriceId) throw new Error("Stripe Price ID missing for this cycle");

    // 3. Create the Checkout Session
    const session = await stripe.checkout.sessions.create({
      payment_method_types: ["card"],
      line_items: [{ price: stripePriceId, quantity: 1 }],
      mode: "subscription",
      success_url: `${Deno.env.get("SITE_URL")}/portal?success=true`,
      cancel_url: `${Deno.env.get("SITE_URL")}/portal?canceled=true`,
      metadata: { 
        profile_id: profile_id.toString(),
        tier_id: tier_id.toString() 
      },
    });

    return new Response(JSON.stringify({ sessionUrl: session.url }), { 
      status: 200, 
      headers: { "Content-Type": "application/json" } 
    });
  } catch (err) {
    return new Response(JSON.stringify({ error: err.message }), { status: 400 });
  }
});