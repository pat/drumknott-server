# frozen_string_literal: true

class Payments::Cancel
  def self.call(site)
    new(site).call
  end

  def initialize(site)
    @site = site
  end

  def call
    return unless active_subscription?

    subscription.cancel
  end

  private

  attr_reader :site

  def active_subscription?
    %w[active past_due].include?(subscription.status)
  end

  def subscription
    @subscription ||= Stripe::Subscription.retrieve(
      site.stripe_subscription_id
    )
  end
end
