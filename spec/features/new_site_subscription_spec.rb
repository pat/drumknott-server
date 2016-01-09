require 'rails_helper'

RSpec.describe 'Creating a new site subscription' do
  let(:site) { Site.make! }

  it 'creates a new Stripe subscription' do |example|
    stripe_cassette(example) do |cassette|
      SubscribeSiteWorker.perform_async site.id, cassette.card_token

      site.reload

      customer     = Stripe::Customer.retrieve site.user.stripe_customer_id
      subscription = customer.subscriptions.retrieve site.stripe_subscription_id

      expect(subscription).to be_present
      expect(subscription.plan.id).to eq(ENV['STRIPE_PLAN_ID'])
    end
  end
end
