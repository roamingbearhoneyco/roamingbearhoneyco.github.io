import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const BREVO_API_KEY = Deno.env.get("BREVO_API_KEY");
const BREVO_LIST_ID = Number(Deno.env.get("BREVO_LIST_ID") || "3"); // your list ID here

serve(async (req) => {
  try {
    const { email, tier } = await req.json();

    if (!email || !tier) {
      return new Response(JSON.stringify({ error: "Missing email or tier" }), { status: 400 });
    }

    const res = await fetch("https://api.brevo.com/v3/contacts", {
      method: "POST",
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "api-key": BREVO_API_KEY!,
      },
      body: JSON.stringify({
        email,
        listIds: [BREVO_LIST_ID],
        attributes: { TIER: tier },
        updateEnabled: true,
      }),
    });

    const data = await res.json();

    if (!res.ok) {
      return new Response(JSON.stringify({ error: data }), { status: 400 });
    }

    // Return Brevo contact ID so the trigger function can update DB
    return new Response(JSON.stringify({ brevo_contact_id: data.id }), { status: 200 });

  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 });
  }
});
