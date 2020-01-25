# frozen_string_literal: true

class Payments::Hooks::PaymentFailed
  def self.call(event)
    new(event.data.object, event.type).call
  end

  def initialize(object, type)
    @object = object
    @type = type
  end

  def call
    Payments::Hooks::InvoiceUpdated.new(object, type).call

    PaymentFailedWorker.perform_async object.id
  end

  private

  attr_reader :object, :type
end
