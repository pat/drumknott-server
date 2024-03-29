# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Viewing invoices", :type => :feature do
  let(:user) { User.make! }
  let(:site) { Site.make! :user => user }

  before :each do
    sign_in_as user
  end

  it "views list and detail" do |example|
    assisted_cassette(example) do |assistant|
      assistant.set_up_user user
      assistant.set_up_site site

      sleep 5 if assistant.recording?

      creation_event = Stripe::Event.
        list(:type => "invoice.created").
        detect do |event|
          event.data.object.customer == user.stripe_customer_id
        end
      Payments::Hooks::InvoiceUpdated.call creation_event

      visit my_invoices_path
      expect(page).to have_content("Paid")

      visit my_invoice_path(user.invoices.first)
      expect(page).to have_content("For #{user.email}")
    end
  end
end
