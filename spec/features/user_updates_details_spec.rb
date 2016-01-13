require 'rails_helper'

RSpec.describe 'Update user details', :type => :feature do
  let(:user) { User.make! }

  before :each do
    sign_in_as user
  end

  it 'updates the email address' do
    visit my_dashboard_path

    fill_in 'Email', with: 'pat@drumknottsearch.com'
    click_button 'Update'

    user.reload
    expect(user.email).to eq('pat@drumknottsearch.com')
  end

  it 'updates the email address on Stripe' do |example|
    stripe_cassette(example) do |cassette|
      cassette.set_up_user user
      visit my_dashboard_path

      fill_in 'Email', with: 'pat@drumknottsearch.com'
      click_button 'Update'

      user.reload
      expect(user.email).to eq('pat@drumknottsearch.com')

      customer = Stripe::Customer.retrieve user.stripe_customer_id
      expect(customer.email).to eq('pat@drumknottsearch.com')
    end
  end
end
