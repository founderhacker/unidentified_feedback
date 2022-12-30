class StripeService

  def self.create_pay_link(feedback_id)
    Stripe.api_key = ENV['stripe_test_api_key']

    pay_link_object = Stripe::PaymentLink.create(
      {
        line_items: [{price: 'price_1MHduzDNIFxLovfoNcmoBxgw', quantity: 1}],
        after_completion: {type: 'redirect', redirect: {url: "http://127.0.0.1:3000/payment_received?feedback_id=#{feedback_id}"}}, # HEADS UP: error might happen with session being undefined, let's see
      },
    )

    pay_link_url = pay_link_object[:url]

    return pay_link_url
  end
end
