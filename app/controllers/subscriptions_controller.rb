class SubscriptionsController < ApplicationController
  def create
    session = Stripe::Checkout::Session.create(
      mode: "subscription",
      client_reference_id: Current.user.id.to_s,
      line_items: [
        {
          price: ENV.fetch("STRIPE_PRICE_ID"),
          quantity: 1
        }
      ],
      success_url: "#{request.base_url}/subscriptions/success?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "#{request.base_url}/premium"
    )

    redirect_to session.url, allow_other_host: true
  end

  def success
  end
end