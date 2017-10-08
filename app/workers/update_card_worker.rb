# frozen_string_literal: true

class UpdateCardWorker
  include Sidekiq::Worker

  def perform(user_id, token)
    user     = User.find user_id
    customer = Payments::GetCustomer.call user

    Payments::SetCard.call customer, token
  end
end
