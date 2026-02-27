// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const BREVO_API_KEY = Deno.env.get("BREVO_API_KEY");
const BREVO_LIST_ID = Number(Deno.env.get("BREVO_LIST_ID") || "3");

const supabase = createClient(
  Deno.env.get("SUPABASE_URL")!,
  Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
);

serve(async (req) => {
  try {
    const payload = await req.json();
    const { record, old_record, table, type } = payload;

    let email, firstName, tierName, profileId;

    // --- GATEKEEPER LOGIC (LOOP PREVENTION) ---
    if (type === 'UPDATE' && old_record) {
      if (table === 'rbhc-table-profiles') {
        // If email and first_name haven't changed, STOP.
        if (record.email === old_record.email && record.first_name === old_record.first_name) {
          return new Response("No profile changes; skipping Brevo.", { status: 200 });
        }
      } 
      
      if (table === 'subscriptions') {
        // If the tier hasn't changed, STOP.
        if (record.tier_id === old_record.tier_id) {
          return new Response("No tier changes; skipping Brevo.", { status: 200 });
        }
      }
    }

    // --- DATA GATHERING ---
    if (table === 'rbhc-table-profiles') {
      profileId = record.id;
      email = record.email;
      firstName = record.first_name;
      
      // Get tier from subscriptions table
      const { data: sub } = await supabase
        .from('subscriptions')
        .select('subscription_tiers(name)')
        .eq('profile_id', profileId)
        .maybeSingle();
      tierName = sub?.subscription_tiers?.name || 'free';

    } else if (table === 'subscriptions') {
      profileId = record.profile_id;
      
      // Get profile and tier details
      const [pRes, tRes] = await Promise.all([
        supabase.from('rbhc-table-profiles').select('email, first_name').eq('id', profileId).single(),
        supabase.from('subscription_tiers').select('name').eq('id', record.tier_id).single()
      ]);
      
      email = pRes.data?.email;
      firstName = pRes.data?.first_name;
      tierName = tRes.data?.name;
    }

    if (!email) return new Response("Missing email", { status: 400 });

    // --- EXTERNAL SYNC (BREVO) ---
    console.log(`📡 Syncing ${email} to Brevo (Tier: ${tierName})`);
    
    const res = await fetch("https://api.brevo.com/v3/contacts", {
      method: "POST",
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "api-key": BREVO_API_KEY as string
      },
      body: JSON.stringify({
        email,
        listIds: [BREVO_LIST_ID],
        attributes: { TIER: tierName, FIRSTNAME: firstName },
        updateEnabled: true,
      })
    });

    // --- DATABASE FEEDBACK ---
    // Only update the profile if Brevo actually created a new ID (Status 201)
    if (res.status === 201) {
      const data = await res.json();
      await supabase
        .from('rbhc-table-profiles')
        .update({ 
          brevo_contact_id: data.id, 
          last_synced: new Date().toISOString() 
        })
        .eq('id', profileId);
    }

    return new Response(JSON.stringify({ success: true }), { status: 200 });

  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 });
  }
});

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/master_brevo_sync' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
