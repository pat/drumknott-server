# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Creating a new site subscription", :type => :feature do
  let(:site) { Site.make! }

  it "creates a new Stripe subscription" do |example|
    assisted_cassette(example) do |assistant|
      SubscribeSiteWorker.perform_async site.id, assistant.card_token

      site.reload

      subscription = Stripe::Subscription.retrieve(site.stripe_subscription_id)

      expect(subscription).to be_present
      expect(subscription.plan.id).to eq(ENV.fetch("STRIPE_PLAN_ID"))
      expect(site.status).to eq("active")

      site.user.reload
      expect(site.user.cache["card"]["last4"]).to eq("4242")
    end
  end

  it "handles cards with no credit" do |example|
    assisted_cassette(example) do |assistant|
      SubscribeSiteWorker.perform_async site.id,
        assistant.card_token("4000000000000002")

      site.reload

      subscriptions = Stripe::Subscription.list(
        :customer => site.user.stripe_customer_id
      )

      expect(subscriptions.count).to be_zero
      expect(site.status).to eq("failure")
      expect(site.status_message).to be_present
    end
  end

  it "handles existing card details" do |example|
    user = User.make!
    sign_in_as user

    assisted_cassette(example) do |assistant|
      assistant.set_up_user user

      visit my_sites_path
      fill_in "Name", :with => "mysite"
      click_button "Create Site"

      site = user.sites.find_by :name => "mysite"
      expect(site).to be_present
      expect(site.status).to eq("active")

      subscription = Stripe::Subscription.retrieve site.stripe_subscription_id
      expect(subscription).to be_present
      expect(subscription.plan.id).to eq(ENV.fetch("STRIPE_PLAN_ID"))
    end
  end
end
