# frozen_string_literal: true

class Payments::SetCard
  def self.call(customer, token)
    new(customer, token).call
  end

  def initialize(customer, token)
    @customer = customer
    @token    = token
  end

  def call
    customer.source = token
    customer.save

    UpdateUserCache.call user, customer
  end

  private

  attr_reader :customer, :token

  def user
    @user ||= User.find_by :stripe_customer_id => customer.id
  end
end
