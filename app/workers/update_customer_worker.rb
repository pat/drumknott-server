# frozen_string_literal: true

class UpdateCustomerWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find user_id
    return if user.stripe_customer_id.blank?

    Stripe::Customer.update(user.stripe_customer_id, :email => user.email)
  end
end
