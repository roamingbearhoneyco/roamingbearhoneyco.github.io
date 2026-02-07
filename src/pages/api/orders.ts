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

    const { data: orders, error } = await supabase
      .from('orders')
      .select(`
        id,
        status,
        tracking_number,
        created_at,
        shipped_at,
        delivered_at,
        order_items (
          id,
          quantity,
          price_paid,
          product_id
        )
      `)
      .eq('user_id', user.id)
      .order('created_at', { ascending: false });

    if (error) {
      return new Response(JSON.stringify({ error: error.message }), { status: 400 });
    }

    // Fetch all products for lookup
    const { data: products } = await supabase
      .from('products')
      .select('*');

    // Enrich order items with product data
    const enrichedOrders = (orders || []).map(order => ({
      ...order,
      order_items: order.order_items.map(item => ({
        ...item,
        products: products?.find(p => p.id === item.product_id)
      }))
    }));

    return new Response(JSON.stringify(enrichedOrders || []), { 
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (err) {
    const message = err instanceof Error ? err.message : 'Internal server error';
    return new Response(JSON.stringify({ error: message }), { status: 500 });
  }
};