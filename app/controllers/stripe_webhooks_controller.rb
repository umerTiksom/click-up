class StripeWebhooksController < ApplicationController
  skip_before_action :require_authentication
  skip_forgery_protection

  def create
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]

    begin
      event = Stripe::Webhook.construct_event(
        payload,
        sig_header,
        ENV.fetch("STRIPE_WEBHOOK_SECRET")
      )
    rescue JSON::ParserError
      render json: { error: "Invalid payload" }, status: :bad_request
      return
    rescue Stripe::SignatureVerificationError
      render json: { error: "Invalid signature" }, status: :bad_request
      return
    end

    Rails.logger.info "Event type: #{event.type}"

    case event.type

    when "checkout.session.completed"
      session = event.data.object

      Rails.logger.info "Client reference ID: #{session.client_reference_id}"
      Rails.logger.info "Stripe customer ID: #{session.customer}"
      Rails.logger.info "Stripe subscription ID: #{session.subscription}"

      handle_checkout_completed(session)

    when "customer.subscription.updated"
      subscription = event.data.object

      Rails.logger.info "Subscription updated: #{subscription.id}"
      Rails.logger.info "Subscription status: #{subscription.status}"

      handle_subscription_updated(subscription)

    when "customer.subscription.deleted"
      subscription = event.data.object

      Rails.logger.info "Subscription deleted: #{subscription.id}"

      handle_subscription_deleted(subscription)

    when "invoice.paid"
      invoice = event.data.object

      Rails.logger.info "Invoice paid: #{invoice.id}"

      handle_invoice_paid(invoice)

    when "invoice.payment_failed"
      invoice = event.data.object

      Rails.logger.info "Invoice payment failed: #{invoice.id}"

      handle_invoice_payment_failed(invoice)
    end

    render json: { received: true }
  end

  private

  def handle_checkout_completed(session)
    user = User.find_by(id: session.client_reference_id)

    Rails.logger.info "Found user: #{user.inspect}"

    return unless user

    user.update!(
      subcription_status: "active",
      stripe_customer_id: session.customer,
      stripe_subcription_id: session.subscription
    )

    Rails.logger.info "User subscription activated successfully!"
  end

  def handle_subscription_updated(subscription)
    user = User.find_by(
      stripe_subcription_id: subscription.id
    )

    return unless user

    user.update!(
      subcription_status: subscription.status,
    subscription_cancel_at: subscription.cancel_at
    )

    Rails.logger.info "User subscription status updated!"
  end

  def handle_subscription_deleted(subscription)
    user = User.find_by(
      stripe_subcription_id: subscription.id
    )

    return unless user

    user.update!(
      subcription_status: "cancelled",
    subscription_cancel_at: nil
    )

    Rails.logger.info "User subscription cancelled!"
  end

  def handle_invoice_paid(invoice)
    Rails.logger.info "Invoice paid successfully!"
  end

  def handle_invoice_payment_failed(invoice)
    subscription_id = invoice.subscription

    user = User.find_by(
      stripe_subcription_id: subscription_id
    )

    return unless user

    user.update!(
      subcription_status: "payment_failed"
    )

    Rails.logger.info "Subscription payment failed!"
  end
end