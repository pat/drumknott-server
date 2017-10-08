# frozen_string_literal: true

class PaymentFailedWorker
  include Sidekiq::Worker

  def perform(stripe_invoice_id)
    invoice = Invoice.find_by :stripe_invoice_id => stripe_invoice_id

    SubscriptionMailer.payment_failed(invoice).deliver_now
  end
end
