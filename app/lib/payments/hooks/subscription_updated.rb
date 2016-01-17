class Payments::Hooks::SubscriptionUpdated
  def self.call(event)
    new(event.data.object).call
  end

  def initialize(subscription)
    @subscription = subscription
  end

  def call
    site.update_attributes! :status => subscription.status

    UpdateSiteCache.call site, subscription
  end

  private

  attr_reader :subscription

  def site
    @site ||= Site.find_by :stripe_subscription_id => subscription.id
  end
end
