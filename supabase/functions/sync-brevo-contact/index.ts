import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const BREVO_API_KEY = Deno.env.get("BREVO_API_KEY");
const BREVO_LIST_ID = Number(Deno.env.get("BREVO_LIST_ID") || "3");

serve(async (req) => {
  try {
    const { email, first_name, tier } = await req.json();

    // 1. Healthcheck
    if (email === 'healthcheck@roamingbearhoneyco.com') {
      return new Response(JSON.stringify({ status: 'awake' }), { status: 200 });
    }

    // 2. Brevo Call
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
        attributes: { TIER: tier, FIRSTNAME: first_name },
        updateEnabled: true, // Crucial: Allows updating existing contacts without error
      })
    });

    // 3. Response Logic (201 Created vs 200/204 Updated)
    if (res.status === 201) {
      const data = await res.json();
      return new Response(JSON.stringify({ brevo_contact_id: data.id }), { status: 201 });
    } 
    
    if (res.ok) {
      // If contact already existed, Brevo returns 204 or 200. 
      // We return null so the DB trigger knows not to overwrite anything.
      return new Response(JSON.stringify({ brevo_contact_id: null }), { status: 200 });
    }

    const error = await res.json();
    return new Response(JSON.stringify({ error }), { status: 400 });

  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 });
  }
});