# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Stripe Webhooks", :type => :request do
  let(:user) { User.make! }
  let(:site) { Site.make! :user => user }

  def post_webhook(event)
    timestamp = Time.current.to_i.to_s
    signature = OpenSSL::HMAC.hexdigest(
      OpenSSL::Digest.new("sha256"),
      StripeEvent.signing_secret,
      "#{timestamp}.#{event.to_json}"
    )

    post "/hooks/stripe",
      :params  => event,
      :as      => :json,
      :headers => {"Stripe-Signature" => "t=#{timestamp}, v1=#{signature}"}
  end

  it "updates site statuses when subscriptions change" do |example|
    assisted_cassette(example) do |assistant|
      site.update :status => "pending"

      assistant.set_up_user user
      assistant.set_up_site site

      Stripe::Subscription.update(
        site.stripe_subscription_id,
        :cancel_at_period_end => true
      )

      subscription = Stripe::Subscription.retrieve(site.stripe_subscription_id)

      update_event = Stripe::Event.list.detect do |event|
        event.data.object.id == subscription.id &&
          event.type == "customer.subscription.updated"
      end

      post_webhook update_event

      site.reload
      expect(site.status).to eq("active")
      expect(site.cache["current_period_end"]).to eq(
        subscription.current_period_end
      )
    end
  end

  it "updates site statuses when subscriptions are cancelled" do |example|
    assisted_cassette(example) do |assistant|
      assistant.set_up_user user
      assistant.set_up_site site

      subscription = Stripe::Subscription.retrieve site.stripe_subscription_id
      subscription.cancel

      delete_event = Stripe::Event.list.detect do |event|
        event.data.object.id == subscription.id &&
          event.type == "customer.subscription.deleted"
      end

      post_webhook delete_event

      site.reload
      expect(site.status).to eq("canceled")
    end
  end

  it "stores invoices when they are created" do |example|
    assisted_cassette(example) do |assistant|
      assistant.set_up_user user
      assistant.set_up_site site

      sleep 5 if assistant.recording?

      creation_event = Stripe::Event.list.detect do |event|
        event.type == "invoice.created"
      end

      post_webhook creation_event

      invoice = user.invoices.first
      expect(invoice).to be_present

      post_webhook creation_event

      expect(user.invoices.count).to eq(1)
    end
  end

  it "sends an email when a payment succeeds" do |example|
    assisted_cassette(example) do |assistant|
      assistant.set_up_user user
      assistant.set_up_site site

      ActionMailer::Base.deliveries.clear

      customer    = Stripe::Customer.retrieve user.stripe_customer_id
      outstanding = Stripe::Invoice.list(:customer => customer.id).
        detect { |invoice| invoice.total > 0 }

      expect(outstanding).to be_present

      creation_event = Stripe::Event.list.detect do |event|
        event.type == "invoice.created"
      end
      post_webhook creation_event

      payment_event = Stripe::Event.list.detect do |event|
        event.type == "invoice.payment_succeeded"
      end
      post_webhook payment_event
      post_webhook payment_event

      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end

  it "sends an email when a payment fails" do |example|
    assisted_cassette(example) do |assistant|
      assistant.set_up_user user, "4000000000000341"
      assistant.set_up_site site, :trial_end => 8.seconds.from_now.to_i

      ActionMailer::Base.deliveries.clear

      sleep 360 if assistant.recording?

      customer       = Stripe::Customer.retrieve user.stripe_customer_id
      unpaid_invoice = Stripe::Invoice.list(:customer => customer.id).
        detect { |invoice| invoice.total > 0 }
      expect { unpaid_invoice.pay }.to raise_error(Stripe::CardError)

      sleep 5 if assistant.recording?

      failure_event = Stripe::Event.list.detect do |event|
        event.type == "invoice.payment_failed"
      end

      post_webhook failure_event

      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
