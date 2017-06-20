require 'rails_helper'

RSpec.describe 'Stripe Webhooks', :type => :request do
  let(:user) { User.make! }
  let(:site) { Site.make! :user => user }

  it 'updates site statuses when subscriptions change' do |example|
    assisted_cassette(example) do |assistant|
      site.update_attributes :status => 'pending'

      assistant.set_up_user user
      assistant.set_up_site site

      customer     = Stripe::Customer.retrieve user.stripe_customer_id
      subscription = customer.subscriptions.retrieve site.stripe_subscription_id
      subscription.delete :at_period_end => true

      event = Stripe::Event.all.detect { |event|
        event.data.object.id == subscription.id &&
        event.type == 'customer.subscription.updated'
      }

      post '/hooks/stripe', :params => {:id => event.id}

      site.reload
      expect(site.status).to eq('active')
      expect(site.cache['current_period_end']).to eq(
        subscription.current_period_end
      )
    end
  end

  it 'updates site statuses when subscriptions are cancelled' do |example|
    assisted_cassette(example) do |assistant|
      assistant.set_up_user user
      assistant.set_up_site site

      customer     = Stripe::Customer.retrieve user.stripe_customer_id
      subscription = customer.subscriptions.retrieve site.stripe_subscription_id
      subscription.delete

      event = Stripe::Event.all.detect { |event|
        event.data.object.id == subscription.id &&
        event.type == 'customer.subscription.deleted'
      }

      post '/hooks/stripe', :params => {:id => event.id}

      site.reload
      expect(site.status).to eq('canceled')
    end
  end

  it 'stores invoices when they are created' do |example|
    assisted_cassette(example) do |assistant|
      assistant.set_up_user user
      assistant.set_up_site site

      event = Stripe::Event.all.detect { |event|
        event.type == 'invoice.created'
      }

      post '/hooks/stripe', :params => {:id => event.id}

      invoice = user.invoices.first
      expect(invoice).to be_present

      post '/hooks/stripe', :params => {:id => event.id}

      expect(user.invoices.count).to eq(1)
    end
  end

  it 'sends an email when a payment succeeds' do |example|
    assisted_cassette(example) do |assistant|
      assistant.set_up_user user
      assistant.set_up_site site

      ActionMailer::Base.deliveries.clear

      customer = Stripe::Customer.retrieve user.stripe_customer_id
      invoice  = customer.invoices.detect { |invoice| invoice.total > 0 }

      event = Stripe::Event.all.detect { |event|
        event.type == 'invoice.created'
      }
      post '/hooks/stripe', :params => {:id => event.id}
      event = Stripe::Event.all.detect { |event|
        event.type == 'invoice.payment_succeeded'
      }
      post '/hooks/stripe', :params => {:id => event.id}
      post '/hooks/stripe', :params => {:id => event.id}

      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end

  it 'sends an email when a payment fails' do |example|
    assisted_cassette(example) do |assistant|
      assistant.set_up_user user, '4000000000000341'
      assistant.set_up_site site, :trial_end => 3.seconds.from_now.to_i

      ActionMailer::Base.deliveries.clear

      sleep 360 if assistant.recording?

      customer = Stripe::Customer.retrieve user.stripe_customer_id
      invoice  = customer.invoices.detect { |invoice| invoice.total > 0 }
      expect { invoice.pay }.to raise_error(Stripe::CardError)

      event = Stripe::Event.all.detect { |event|
        event.type == 'invoice.payment_failed'
      }

      post '/hooks/stripe', :params => {:id => event.id}

      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
