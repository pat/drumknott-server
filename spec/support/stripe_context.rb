class StripeContext
  def initialize(cassette)
    @cassette = cassette
  end

  def card_token(card = '4242424242424242')
    return 'tok_non_live_example' unless cassette.recording?

    Stripe::Token.create(:card => {
      :number    => card,
      :exp_month => 1,
      :exp_year  => (Time.current.year + 2),
      :cvc       => '123'
    }).id
  end

  def set_up_site(site)
    site.reload # so user is up-to-date.

    customer     = Stripe::Customer.retrieve site.user.stripe_customer_id
    subscription = customer.subscriptions.create :plan => ENV['STRIPE_PLAN_ID']

    site.update_attributes! :stripe_subscription_id => subscription.id
  end

  def set_up_user(user)
    customer = Stripe::Customer.create email: user.email

    customer.sources.create :source => card_token
    user.update_attributes! :stripe_customer_id => customer.id
  end

  private

  attr_reader :cassette
end
