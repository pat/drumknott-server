# frozen_string_literal: true

Stripe.api_key             = ENV["STRIPE_SECRET_KEY"]
StripeEvent.signing_secret = ENV["STRIPE_SIGNING_SECRET"] || "test-placeholder"

StripeEvent.configure do |events|
  events.subscribe "customer.subscription.updated",
    Payments::Hooks::SubscriptionUpdated
  events.subscribe "customer.subscription.deleted",
    Payments::Hooks::SubscriptionUpdated

  events.subscribe "invoice.created",           Payments::Hooks::InvoiceUpdated
  events.subscribe "invoice.updated",           Payments::Hooks::InvoiceUpdated
  events.subscribe "invoice.payment_succeeded", Payments::Hooks::InvoiceUpdated
  events.subscribe "invoice.payment_failed",    Payments::Hooks::PaymentFailed
end
