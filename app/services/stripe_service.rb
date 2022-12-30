class StripeService

  def self.create_pay_link(feedback_id)
    return nil unless ENV['stripe_price_id'].present?

    pay_link_object = Stripe::PaymentLink.create(
      {
        line_items: [
          { price: ENV['stripe_price_id'], quantity: 1 }
        ],
        after_completion: {
          type: 'redirect',
          redirect: { url: "#{ENV['base_url']}/payment_received?feedback_id=#{feedback_id}" }
        }
      }
    )

    pay_link_object[:url]
  end
end
