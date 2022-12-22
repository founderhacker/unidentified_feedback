Stripe.api_key = ENV['stripe_test_api_key']

Stripe::PaymentLink.create(
  {
    line_items: [{price: 'price_1MHduzDNIFxLovfoNcmoBxgw', quantity: 1}],
    after_completion: {type: 'redirect', redirect: {url: "http://127.0.0.1:3000/thanks?feedback_id="}},
  },
)