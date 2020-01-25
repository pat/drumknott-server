# frozen_string_literal: true

class Payments::Hooks::InvoiceUpdated
  def self.call(event)
    new(event.data.object, event.type).call
  end

  def initialize(object, type)
    @object = object
    @type = type
  end

  def call
    invoice.data_will_change!
    invoice.update :data => object.to_hash

    PaymentSucceededWorker.perform_async invoice.id if paid?
  end

  private

  attr_reader :object, :type

  def invoice
    @invoice ||= user.invoices.find_by(
      :stripe_invoice_id => object.id
    ) || user.invoices.create(
      :stripe_invoice_id => object.id,
      :invoiced_at       => Time.zone.at(object.date)
    )
  end

  def paid?
    type == "invoice.payment_succeeded" && object.paid
  end

  def user
    @user ||= User.find_by :stripe_customer_id => object.customer
  end
end
