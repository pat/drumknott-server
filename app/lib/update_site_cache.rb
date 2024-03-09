# frozen_string_literal: true

class UpdateSiteCache
  CACHED_KEYS = %i[ current_period_start current_period_end ].freeze

  def self.call(site, subscription = nil)
    new(site, subscription).call
  end

  def initialize(site, subscription)
    @site         = site
    @subscription = subscription
  end

  def call
    site.cache_will_change!
    site.cache = subscription.to_hash.slice(*CACHED_KEYS)
    site.save!
  end

  private

  attr_reader :site

  def subscription
    @subscription ||= Stripe::Subscription.retrieve(
      site.stripe_subscription_id
    )
  end
end
