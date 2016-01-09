class Payments::Subscribe
  def self.call(site, token)
    new(site, token).call
  end

  def initialize(site, token)
    @site, @token = site, token
  end

  def call
    begin
      Payments::SetCard.call customer, token if token.present?

      site.update_attributes!(
        :stripe_subscription_id => subscription.id,
        :status                 => subscription.status
      )
    rescue => error
      raise error unless Bugsnag.configuration.should_notify?

      Bugsnag.notify error, :user => {
        :id    => user.id,
        :email => user.email
      }

      site.update_attributes!(
        :status         => 'failure',
        :status_message => error.message
      )
    end
  end

  private

  attr_reader :site, :token

  delegate :user, :to => :site

  def customer
    @customer ||= Payments::GetCustomer.call user
  end

  def subscription
    @subscription ||= customer.subscriptions.create(
      :plan => ENV['STRIPE_PLAN_ID']
    )
  end
end
