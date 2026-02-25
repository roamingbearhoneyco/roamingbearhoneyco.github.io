// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import Stripe from "https://esm.sh/stripe@11.1.0?target=deno";

const stripe = new Stripe(Deno.env.get("STRIPE_SECRET_KEY")!, {
  httpClient: Stripe.createFetchHttpClient(),
});

const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
);

serve(async (req) => {
  try {
    // 1. Get all paid tiers from your DB
    const { data: tiers, error: fetchError } = await supabase
      .from("subscription_tiers")
      .select("*")
      .gt("id", 1); // Skip the free tier

    if (fetchError) throw fetchError;

    const results = [];

    for (const tier of tiers) {
      console.log(`Syncing tier: ${tier.display_name}`);

      // 2. Create Product in Stripe if it doesn't exist
      let productId = tier.stripe_product_id;
      if (!productId) {
        const product = await stripe.products.create({
          name: tier.display_name,
          description: tier.description,
        });
        productId = product.id;
      }

      // 3. Create Prices (Monthly, 6-Month, Yearly)
      // Prices in DB are stored in cents (e.g. 1299 = $12.99)
      const monthlyPrice = await stripe.prices.create({
        unit_amount: tier.price_monthly,
        currency: "usd",
        recurring: { interval: "month" },
        product: productId,
      });

      const sixMonthPrice = await stripe.prices.create({
        unit_amount: tier.price_6month,
        currency: "usd",
        recurring: { interval: "month", interval_count: 6 },
        product: productId,
      });

      const yearlyPrice = await stripe.prices.create({
        unit_amount: tier.price_yearly,
        currency: "usd",
        recurring: { interval: "year" },
        product: productId,
      });

      // 4. Update the DB with the new IDs
      const { error: updateError } = await supabase
        .from("subscription_tiers")
        .update({
          stripe_product_id: productId,
          stripe_price_id_monthly: monthlyPrice.id,
          stripe_price_id_6month: sixMonthPrice.id,
          stripe_price_id_yearly: yearlyPrice.id,
        })
        .eq("id", tier.id);

      if (updateError) throw updateError;
      
      results.push({ name: tier.name, productId });
    }

    return new Response(JSON.stringify({ message: "Sync complete", results }), {
      headers: { "Content-Type": "application/json" },
      status: 200,
    });
  } catch (err) {
    return new Response(JSON.stringify({ error: err.message }), { status: 500 });
  }
});

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'https://roqwrtsmcisdxhgthpem.supabase.co/functions/v1/sync-tiers-to-stripe' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
