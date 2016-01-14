class PaymentSucceededWorker
  include Sidekiq::Worker

  def perform(invoice_id)
    invoice = Invoice.find invoice_id
    return if invoice.sent?

    invoice.update_attributes! :sent_at => Time.zone.now
    SubscriptionMailer.payment_succeeded(invoice).deliver_now
  end
end
