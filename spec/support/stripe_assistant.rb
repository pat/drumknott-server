# frozen_string_literal: true

class StripeAssistant
  delegate :recording?, :to => :vcr_cassette

  def initialize(vcr_cassette)
    @vcr_cassette = vcr_cassette
  end

  def card_token(card = "4242424242424242")
    return "tok_non_live_example" unless recording?

    Stripe::Token.create(:card => {
      :number    => card,
      :exp_month => 1,
      :exp_year  => (Time.current.year + 2),
      :cvc       => "123"
    }).id
  end

  def set_up_site(site, subscription_attributes = {})
    site.reload # so user is up-to-date.

    customer     = Stripe::Customer.retrieve site.user.stripe_customer_id
    subscription = customer.subscriptions.create(
      {:plan => ENV["STRIPE_PLAN_ID"]}.merge(subscription_attributes)
    )

    site.update_attributes! :stripe_subscription_id => subscription.id
  end

  def set_up_user(user, card = "4242424242424242")
    customer = Stripe::Customer.create email: user.email

    customer.sources.create :source => card_token(card)
    user.update_attributes! :stripe_customer_id => customer.id

    UpdateUserCache.call user, customer.refresh
  end

  def setup
    clear
    create_plan
  end

  private

  attr_reader :vcr_cassette

  def clear
    Stripe::Customer.all.each &:delete
    Stripe::Coupon.all.each &:delete
    Stripe::Plan.all.each &:delete
  end

  def create_plan
    Stripe::Plan.create(
      :id             => ENV["STRIPE_PLAN_ID"],
      :amount         => 3_00,
      :currency       => "USD",
      :interval       => "month",
      :interval_count => 1,
      :name           => "Drumknott Test"
    )
  end
end
