class StripeCassette
  def self.call(example, &block)
    new(example, &block).call
  end

  def initialize(example, &block)
    @example, @block = example, block
  end

  def call
    VCR.use_cassette("#{folder}/#{file}") do |cassette|
      clear
      create_plan

      block.call StripeContext.new(cassette)
    end
  end

  private

  attr_reader :example, :block

  def clear
    Stripe::Customer.all.each &:delete
    Stripe::Coupon.all.each &:delete
    Stripe::Plan.all.each &:delete
  end

  def create_plan
    Stripe::Plan.create(
      :id             => ENV['STRIPE_PLAN_ID'],
      :amount         => 3_00,
      :currency       => 'USD',
      :interval       => 'month',
      :interval_count => 1,
      :name           => 'Drumknott Test'
    )
  end

  def file
    example.metadata[:description].downcase.gsub(/\s+/, '_').gsub(/[\W]+/, '')
  end

  def folder
    File.basename example.metadata[:file_path], '_spec.rb'
  end
end
