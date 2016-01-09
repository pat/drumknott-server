module StripeHelpers
  def stripe_cassette(example, &block)
    StripeCassette.call example, &block
  end
end

RSpec.configure do |config|
  config.include StripeHelpers
end
