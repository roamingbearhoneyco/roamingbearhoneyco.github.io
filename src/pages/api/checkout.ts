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

    // Get user profile to link with subscription
    const { data: profile, error: profileError } = await supabase
      .from('rbhc-table-profiles')
      .select('id, email')
      .eq('user_id', user.id)
      .single();

    if (profileError || !profile) {
      return new Response(JSON.stringify({ error: 'Profile not found' }), { status: 404 });
    }

    const body: CheckoutRequest = await request.json();

    // Get existing subscription to check for stripe_customer_id
    const { data: subscription } = await supabase
      .from('subscriptions')
      .select('stripe_customer_id')
      .eq('profile_id', profile.id)
      .single();

    // Get Supabase project URL for calling edge function
    const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL;
    if (!supabaseUrl) {
      throw new Error('SUPABASE_URL not configured');
    }

    // Call the create-checkout-session edge function
    const edgeFunctionResponse = await fetch(
      `${supabaseUrl}/functions/v1/create-checkout-session`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        body: JSON.stringify({
          profile_id: profile.id,
          tier_id: body.tier_id,
          billing_cycle: body.billing_cycle,
          stripe_customer_id: subscription?.stripe_customer_id,
        }),
      }
    );

    if (!edgeFunctionResponse.ok) {
      const error = await edgeFunctionResponse.json();
      return new Response(JSON.stringify(error), { status: edgeFunctionResponse.status });
    }

    const data = await edgeFunctionResponse.json();
    return new Response(JSON.stringify(data), { 
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (err) {
    const message = err instanceof Error ? err.message : 'Internal server error';
    console.error('Checkout error:', err);
    return new Response(JSON.stringify({ error: message }), { status: 500 });
  }
};