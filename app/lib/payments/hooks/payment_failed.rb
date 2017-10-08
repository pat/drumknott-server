# frozen_string_literal: true

class Payments::Hooks::PaymentFailed
  def self.call(event)
    new(event.data.object).call
  end

  def initialize(object)
    @object = object
  end

  def call
    Payments::Hooks::InvoiceUpdated.new(object).call

    PaymentFailedWorker.perform_async object.id
  end

  private

  attr_reader :object
end
