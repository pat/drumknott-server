# frozen_string_literal: true

class Payments::Subscribe
  def self.call(site, token)
    new(site, token).call
  end

  def initialize(site, token)
    @site  = site
    @token = token
  end

  def call
    Payments::SetCard.call customer, token if token.present?

    update_status
    update_cache
  rescue StandardError => error
    raise error if Rails.env.development?

    notify error
    mark_as_failed_with error
  end

  private

  attr_reader :site, :token

  delegate :user, :to => :site

  def customer
    @customer ||= Payments::GetCustomer.call user
  end

  def mark_as_failed_with(error)
    site.update!(
      :status         => "failure",
      :status_message => error.message
    )
  end

  def notify(error)
    Bugsnag.notify error do |report|
      report.add_tab :user,
        :id    => user.id,
        :email => user.email
    end
  end

  def subscription
    @subscription ||= customer.subscriptions.create(
      :plan => ENV.fetch("STRIPE_PLAN_ID", nil)
    )
  end

  def update_cache
    UpdateSiteCache.call site, subscription
  end

  def update_status
    site.update!(
      :stripe_subscription_id => subscription.id,
      :status                 => subscription.status
    )
  end
end
