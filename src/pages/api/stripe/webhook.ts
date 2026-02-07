import type { APIRoute } from 'astro';

export const POST: APIRoute = async ({ request }) => {
  try {
    // TODO: Verify Stripe signature
    // const sig = request.headers.get('stripe-signature');
    // const event = stripe.webhooks.constructEvent(body, sig, process.env.STRIPE_WEBHOOK_SECRET);

    const body = await request.json() as any;
    const eventType = body.type;

    console.log(`[Stripe Webhook] Received: ${eventType}`);

    // TODO: Handle events:
    // - checkout.session.completed
    // - customer.subscription.updated
    // - customer.subscription.deleted

    return new Response(JSON.stringify({ received: true }), { 
      status: 200,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (err) {
    console.error('Webhook error:', err);
    return new Response(JSON.stringify({ error: 'Webhook processing failed' }), { status: 400 });
  }
};