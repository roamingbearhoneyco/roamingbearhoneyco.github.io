// /supabase/functions/sync-brevo-contact/index.ts
import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

// Your Brevo API key should be in Supabase secrets, not hardcoded
const BREVO_API_KEY = Deno.env.get("BREVO_API_KEY");
const BREVO_LIST_ID = Deno.env.get("BREVO_LIST_ID"); // ID of your Free tier list

serve(async (req) => {
  try {
    const { email, tier } = await req.json();

    if (!email || !tier) {
      return new Response(JSON.stringify({ error: "Missing email or tier" }), { status: 400 });
    }

    // Make request to Brevo API
    const response = await fetch("https://api.brevo.com/v3/contacts", {
      method: "POST",
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "api-key": BREVO_API_KEY!,
      },
      body: JSON.stringify({
        email,
        listIds: [Number(BREVO_LIST_ID)],
        attributes: { TIER: tier },
        updateEnabled: true,
      }),
    });

    const data = await response.json();

    if (!response.ok) {
      return new Response(JSON.stringify({ error: data }), { status: 400 });
    }

    // Return Brevo contact ID back to caller
    return new Response(JSON.stringify({ brevo_contact_id: data.id }), { status: 200 });

  } catch (err) {
    return new Response(JSON.stringify({ error: err.message }), { status: 500 });
  }
});
