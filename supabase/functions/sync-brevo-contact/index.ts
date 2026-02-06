import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
const BREVO_API_KEY = Deno.env.get("BREVO_API_KEY");
const BREVO_LIST_ID = Number(Deno.env.get("BREVO_LIST_ID") || "3"); // your list ID here
serve(async (req)=>{
  try {
    const { email, tier, first_name } = await req.json();
    if (!email || !tier || !first_name) {
      return new Response(JSON.stringify({
        error: "Missing email, tier or first name"
      }), {
        status: 400
      });
    }
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
        attributes: {
          TIER: tier,
          FIRSTNAME: first_name,
        },
        updateEnabled: true,
      })
    });
    // 1. HANDLE EXISTING USER (Success - No Content)
    // Brevo returns 204 when it updates an existing contact with updateEnabled: true
    if (res.status === 204) {
      console.log(`Successfully updated existing contact: ${email}`);
      return new Response(JSON.stringify({
        message: "Contact updated successfully",
        brevo_contact_id: null // Tell the DB trigger there's no NEW id to write
      }), { 
        status: 200, 
        headers: { "Content-Type": "application/json" } 
      });
    }

    // 2. HANDLE NEW USER (Success - Created)
    // Brevo returns 201 when it creates a brand new contact
    if (res.ok) {
      const data = await res.json();
      console.log(`Successfully created new contact: ${email} (ID: ${data.id})`);
      return new Response(JSON.stringify({
        brevo_contact_id: data.id 
      }), { 
        status: 200, 
        headers: { "Content-Type": "application/json" } 
      });
    }

    // 3. HANDLE API ERRORS (400, 401, 403, etc.)
    const errorData = await res.json();
    console.error("Brevo API Error:", errorData);
    return new Response(JSON.stringify({ 
      error: "Brevo API Error", 
      details: errorData 
    }), { 
      status: 400, 
      headers: { "Content-Type": "application/json" } 
    });

  } catch (error) {
    // This catches the SyntaxError that was causing your 500s
    console.error("Edge Function Crash:", error.message);
    return new Response(JSON.stringify({ 
      error: "Internal Server Error", 
      message: error.message 
    }), { 
      status: 500, 
      headers: { "Content-Type": "application/json" } 
    });
  }
});
