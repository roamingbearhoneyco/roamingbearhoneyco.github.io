import type { APIRoute } from 'astro';
import { supabase } from '../../lib/supabase';

interface CheckoutRequest {
  tier_id: number;
  billing_cycle: number;
}

export const POST: APIRoute = async ({ request }) => {
  try {
    const authHeader = request.headers.get('authorization');
    if (!authHeader) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401 });
    }

    const token = authHeader.replace('Bearer ', '');
    const { data: { user }, error: userError } = await supabase.auth.getUser(token);
    
    if (userError || !user) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401 });
    }

    const body: CheckoutRequest = await request.json();

    const { data: tier, error: tierError } = await supabase
      .from('subscription_tiers')
      .select('*')
      .eq('id', body.tier_id)
      .single();

    if (tierError || !tier) {
      return new Response(JSON.stringify({ error: 'Tier not found' }), { status: 404 });
    }

    // TODO: Integrate Stripe API
    // const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
    // const session = await stripe.checkout.sessions.create({...});
    
    const priceInCents = body.billing_cycle === 1 ? tier.price_monthly : 
                        body.billing_cycle === 6 ? tier.price_6month : 
                        tier.price_yearly;

    return new Response(JSON.stringify({ 
      message: 'Stripe integration pending',
      tier: tier.name,
      billing_cycle: body.billing_cycle,
      priceInCents,
      status: 'placeholder'
    }), { 
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (err) {
    const message = err instanceof Error ? err.message : 'Internal server error';
    return new Response(JSON.stringify({ error: message }), { status: 500 });
  }
};