import type { APIRoute } from 'astro';
import { supabase } from '../../lib/supabase';

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
    
    const { data: profile } = await supabase
    .from('rbhc-table-profiles')
    .select('id')
    .eq('user_id', user.id)
    .single();

    if (!profile) return new Response(JSON.stringify({ error: 'Profile not found' }), { status: 404 });

    const { data: subscription, error } = await supabase
      .from('subscriptions')
      .select('*')
      .eq('profile_id', profile.id)
      .single();

    if (error) {
      return new Response(JSON.stringify({ error: error.message }), { status: 400 });
    }

    // Fetch tier separately to avoid RLS/PostgREST join issues
    const { data: tier, error: tierError } = await supabase
      .from('subscription_tiers')
      .select('*')
      .eq('id', subscription.tier_id)
      .single();

    if (tierError) {
      return new Response(JSON.stringify({ error: tierError.message }), { status: 400 });
    }

    const result = {
      ...subscription,
      subscription_tiers: tier
    };

    return new Response(JSON.stringify(result), { 
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (err) {
    const message = err instanceof Error ? err.message : 'Internal server error';
    return new Response(JSON.stringify({ error: message }), { status: 500 });
  }
};