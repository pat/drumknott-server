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

  private

  attr_reader :cassette
end
