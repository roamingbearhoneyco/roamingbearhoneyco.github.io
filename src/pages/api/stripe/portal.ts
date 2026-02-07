import type { APIRoute } from 'astro';
import { supabase } from '../../../lib/supabase';

export const GET: APIRoute = async ({ request }) => {
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

    const { data: subscription, error } = await supabase
      .from('subscriptions')
      .select('stripe_customer_id')
      .eq('user_id', user.id)
      .single();

    if (error || !subscription?.stripe_customer_id) {
      return new Response(JSON.stringify({ error: 'No active subscription found' }), { status: 404 });
    }

    // TODO: Generate Stripe portal session
    // const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
    // const session = await stripe.billingPortal.sessions.create({...});
    
    return new Response(JSON.stringify({ 
      message: 'Stripe portal integration pending',
      customerId: subscription.stripe_customer_id
    }), { 
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (err) {
    const message = err instanceof Error ? err.message : 'Internal server error';
    return new Response(JSON.stringify({ error: message }), { status: 500 });
  }
};