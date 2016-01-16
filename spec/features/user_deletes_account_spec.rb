require 'rails_helper'

RSpec.describe 'Deleting account', :type => :feature do
  let(:user) { User.make! }
  let(:site) { Site.make! :user => user }

  before :each do
    sign_in_as user
  end

  it 'removes all data' do |example|
    stripe_cassette(example) do |cassette|
      cassette.set_up_user user
      cassette.set_up_site site

      ActionMailer::Base.deliveries.clear

      visit my_dashboard_path
      click_link 'Delete My Account'

      customer = Stripe::Customer.retrieve user.stripe_customer_id
      expect(customer.subscriptions.count).to be_zero
      expect(User.find_by(:id => user.id)).to be_nil
      expect(ActionMailer::Base.deliveries.length).to eq(1)
    end
  end
end

