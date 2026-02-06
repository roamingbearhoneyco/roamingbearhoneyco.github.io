import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const BREVO_API_KEY = Deno.env.get("BREVO_API_KEY");
const BREVO_LIST_ID = Number(Deno.env.get("BREVO_LIST_ID") || "3");

serve(async (req) => {
  try {
    // Read the body once into a variable
    const body = await req.json();
    const { email, first_name, tier } = body;

    // 1. GITHUB KEEPALIVE CHECK
    // If it's our healthcheck email, respond and exit immediately.
    if (email === 'healthcheck@roamingbearhoneyco.com') {
      return new Response(
        JSON.stringify({ status: 'awake' }), 
        { status: 200, headers: { "Content-Type": "application/json" } }
      );
    }

    // 2. VALIDATION FOR REAL REQUESTS
    if (!email || !tier || !first_name) {
      return new Response(JSON.stringify({ error: "Missing data" }), { status: 400 });
    }

    // 3. BREVO API CALL
    const res = await fetch("https://api.brevo.com/v3/contacts", {
      method: "POST",
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "api-key": BREVO_API_KEY
      },
      body: JSON.stringify({
        email,
        listIds: [BREVO_LIST_ID],
        attributes: { TIER: tier, FIRSTNAME: first_name },
        updateEnabled: true,
      })
    });

    // 4. RESPONSE LOGIC
    if (res.status === 204 || res.ok) {
      const data = res.status === 204 ? {} : await res.json();
      return new Response(JSON.stringify({
        message: "Success",
        brevo_contact_id: data.id || null 
      }), { status: 200 });
    }

    // Handle Brevo Errors
    const errorData = await res.json();
    return new Response(JSON.stringify({ error: errorData }), { status: 400 });

  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 });
  }
});