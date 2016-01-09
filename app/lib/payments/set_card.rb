class Payments::SetCard
  def self.call(customer, token)
    new(customer, token).call
  end

  def initialize(customer, token)
    @customer, @token = customer, token
  end

  def call
    source = customer.sources.create :source => token

    customer.default_source = source.id
    customer.save
  end

  private

  attr_reader :customer, :token
end
