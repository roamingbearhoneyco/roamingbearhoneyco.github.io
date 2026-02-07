import type { APIRoute } from 'astro';
import { supabase } from '../../lib/supabase';

interface UpdateProfileRequest {
  first_name?: string;
  merch_preferences?: string[];
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

    const body: UpdateProfileRequest = await request.json();

    if (body.first_name && body.first_name.length > 50) {
      return new Response(JSON.stringify({ error: 'First name too long' }), { status: 400 });
    }

    if (body.merch_preferences && !Array.isArray(body.merch_preferences)) {
      return new Response(JSON.stringify({ error: 'merch_preferences must be an array' }), { status: 400 });
    }

    const updateData: any = {};
    if (body.first_name !== undefined) updateData.first_name = body.first_name;
    if (body.merch_preferences !== undefined) updateData.merch_preferences = body.merch_preferences;

    const { data: profile, error } = await supabase
      .from('rbhc-table-profiles')
      .update(updateData)
      .eq('user_id', user.id)
      .select()
      .single();

    if (error) {
      return new Response(JSON.stringify({ error: error.message }), { status: 400 });
    }

    return new Response(JSON.stringify(profile), { 
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (err) {
    const message = err instanceof Error ? err.message : 'Internal server error';
    return new Response(JSON.stringify({ error: message }), { status: 500 });
  }
};