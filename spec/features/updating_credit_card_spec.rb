# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Updating credit card" do
  let(:user) { User.make! }
  let(:site) { Site.make! :user => user }

  it "updates card details" do |example|
    assisted_cassette(example) do |assistant|
      assistant.set_up_user user
      assistant.set_up_site site

      customer = Stripe::Customer.retrieve user.stripe_customer_id
      expect(customer.sources.first.last4).to eq("4242")

      UpdateCardWorker.perform_async user.id,
        assistant.card_token("5555555555554444")

      customer = Stripe::Customer.retrieve user.stripe_customer_id
      expect(customer.sources.first.last4).to eq("4444")

      user.reload
      expect(user.cache["card"]["last4"]).to eq("4444")
    end
  end

  it "retries failed payments" do |example|
    assisted_cassette(example) do |assistant|
      assistant.set_up_user user, "4000000000000341"
      assistant.set_up_site site, :trial_end => 3.seconds.from_now.to_i

      customer = Stripe::Customer.retrieve user.stripe_customer_id
      expect(customer.sources.first.last4).to eq("0341")

      sleep 360 if assistant.recording?

      customer = Stripe::Customer.retrieve user.stripe_customer_id
      invoice  = customer.invoices.detect { |invoice| invoice.total > 0 }
      expect { invoice.pay }.to raise_error(Stripe::CardError)

      UpdateCardWorker.perform_async user.id,
        assistant.card_token("5555555555554444")

      customer = Stripe::Customer.retrieve user.stripe_customer_id
      expect(customer.sources.first.last4).to eq("4444")

      subscription = customer.subscriptions.retrieve site.stripe_subscription_id
      expect(subscription.status).to eq("active")
    end
  end
end
