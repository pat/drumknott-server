class Payments::Hooks::InvoiceUpdated
  def self.call(event)
    new(event.data.object).call
  end

  def initialize(object)
    @object = object
  end

  def call
    invoice.data_will_change!
    invoice.update_attributes :data => object.to_hash
  end

  private

  attr_reader :object

  def invoice
    @invoice ||= user.invoices.find_by(
      :stripe_invoice_id => object.id
    ) || user.invoices.create(
      :stripe_invoice_id => object.id,
      :invoiced_at       => Time.zone.at(object.date)
    )
  end

  def user
    @user ||= User.find_by :stripe_customer_id => object.customer
  end
end
