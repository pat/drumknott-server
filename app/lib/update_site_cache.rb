# frozen_string_literal: true

class UpdateSiteCache
  def self.call(site, subscription = nil)
    new(site, subscription).call
  end

  def initialize(site, subscription)
    @site         = site
    @subscription = subscription
  end

  def call
    site.cache_will_change!
    site.cache = subscription.to_hash.slice(
      %i[ current_period_start current_period_end ]
    )
    site.save!
  end

  private

  attr_reader :site

  def customer
    Stripe::Customer.retrieve site.user.stripe_customer_id
  end

  def subscription
    @subscription ||= customer.subscriptions.retrieve(
      site.stripe_subscription_id
    )
  end
end
