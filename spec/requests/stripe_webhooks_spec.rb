require 'rails_helper'

RSpec.describe 'Stripe Webhooks', :type => :request do
  let(:user) { User.make! }
  let(:site) { Site.make! :user => user }

  it 'updates site statuses when subscriptions change' do |example|
    stripe_cassette(example) do |cassette|
      site.update_attributes :status => 'pending'

      cassette.set_up_user user
      cassette.set_up_site site

      customer     = Stripe::Customer.retrieve user.stripe_customer_id
      subscription = customer.subscriptions.retrieve site.stripe_subscription_id
      subscription.delete :at_period_end => true

      event = Stripe::Event.all.detect { |event|
        event.data.object.id == subscription.id &&
        event.type == 'customer.subscription.updated'
      }

      post '/hooks/stripe', id: event.id

      site.reload
      expect(site.status).to eq('active')
    end
  end

  it 'updates site statuses when subscriptions are cancelled' do |example|
    stripe_cassette(example) do |cassette|
      cassette.set_up_user user
      cassette.set_up_site site

      customer     = Stripe::Customer.retrieve user.stripe_customer_id
      subscription = customer.subscriptions.retrieve site.stripe_subscription_id
      subscription.delete

      event = Stripe::Event.all.detect { |event|
        event.data.object.id == subscription.id &&
        event.type == 'customer.subscription.deleted'
      }

      post '/hooks/stripe', id: event.id

      site.reload
      expect(site.status).to eq('canceled')
    end
  end
end
