require 'rails_helper'

RSpec.describe 'Removing sites', type: :feature do
  let(:user) { User.make! }
  let(:site) { Site.make! user: user }

  before :each do
    sign_in_as user
  end

  it 'cancels the subscription' do |example|
    stripe_cassette(example) do |cassette|
      cassette.set_up_user user
      cassette.set_up_site site

      visit my_site_path(site)
      click_link 'Cancel and Delete'

      customer = Stripe::Customer.retrieve user.stripe_customer_id
      expect(customer.subscriptions.count).to be_zero
    end
  end
end
