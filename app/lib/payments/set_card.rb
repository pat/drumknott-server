class Payments::SetCard
  def self.call(customer, token)
    new(customer, token).call
  end

  def initialize(customer, token)
    @customer, @token = customer, token
  end

  def call
    customer.source = token
    customer.save

    user.cache_will_change!
    user.cache['card'] = customer.sources.first.to_hash.slice(
      *%i( last4 exp_month exp_year )
    )
    user.save!
  end

  private

  attr_reader :customer, :token

  def user
    @user ||= User.find_by :stripe_customer_id => customer.id
  end
end
