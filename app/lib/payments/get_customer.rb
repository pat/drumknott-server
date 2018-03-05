# frozen_string_literal: true

class Payments::GetCustomer
  def self.call(user)
    new(user).call
  end

  def initialize(user)
    @user = user
  end

  def call
    if user.stripe_customer_id.present?
      Stripe::Customer.retrieve user.stripe_customer_id
    else
      customer = Stripe::Customer.create :email => user.email
      user.update :stripe_customer_id => customer.id

      customer
    end
  end

  private

  attr_reader :user
end
