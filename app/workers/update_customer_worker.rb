class UpdateCustomerWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find user_id
    return unless user.stripe_customer_id.present?

    customer = Stripe::Customer.retrieve user.stripe_customer_id
    customer.email = user.email
    customer.save
  end
end
