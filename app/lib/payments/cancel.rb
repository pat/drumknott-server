class Payments::Cancel
  def self.call(site)
    new(site).call
  end

  def initialize(site)
    @site = site
  end

  def call
    return unless active_subscription?

    subscription.delete
  end

  private

  attr_reader :site

  def active_subscription?
    subscription.status == 'active' || subscription.status == 'past_due'
  end

  def customer
    Payments::GetCustomer.call site.user
  end

  def subscription
    @subscription ||= customer.subscriptions.retrieve(
      site.stripe_subscription_id
    )
  end
end
