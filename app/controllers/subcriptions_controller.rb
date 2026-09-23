class SubcriptionsController < ApplicationController
  def create
    session = Stripe::Checkout::Session.create(
      mode: "subscription",
      customer_email: Current.user.email_address,
      line_items: [
        {
          price: ENV["STRIPE_PREMIUM_PRICE_ID"],
          quantity: 1
        }
      ],
      success_url: subscription_success_url,
      cancel_url: subscription_cancel_url
    )

    redirect_to session.url, allow_other_host: true
  end

  def success
  end

  def cancel
  end
end
