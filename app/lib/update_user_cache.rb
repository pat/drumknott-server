# frozen_string_literal: true

class UpdateUserCache
  def self.call(user, customer = nil)
    new(user, customer).call
  end

  def initialize(user, customer)
    @user     = user
    @customer = customer
  end

  def call
    user.cache_will_change!
    user.cache["card"] = customer.sources.first.to_hash.slice(
      *%i[ last4 exp_month exp_year ]
    )
    user.save!
  end

  private

  attr_reader :user

  def customer
    @customer ||= Stripe::Customer.retrieve user.stripe_customer_id
  end
end
