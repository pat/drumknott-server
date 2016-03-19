require 'rails_helper'

RSpec.describe 'Update user details', :type => :feature do
  let(:user) { User.make! }

  before :each do
    sign_in_as user
  end

  it 'updates the email address' do
    visit my_dashboard_path

    fill_in 'Email', :with => 'pat@drumknottsearch.com'
    click_button 'Update'

    user.reload
    expect(user.email).to eq('pat@drumknottsearch.com')
  end

  it 'updates the email address on Stripe' do |example|
    assisted_cassette(example) do |assistant|
      assistant.set_up_user user
      visit my_dashboard_path

      fill_in 'Email', :with => 'pat@drumknottsearch.com'
      click_button 'Update'

      user.reload
      expect(user.email).to eq('pat@drumknottsearch.com')

      customer = Stripe::Customer.retrieve user.stripe_customer_id
      expect(customer.email).to eq('pat@drumknottsearch.com')
    end
  end

  it 'changes password' do
    visit my_dashboard_path

    fill_in 'New Password',     :with => 'wossname'
    fill_in 'Confirm Password', :with => 'wossname'
    click_button 'Change Password'

    fill_in 'Email',    with: user.email
    fill_in 'Password', with: 'wossname'
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Log out')
  end
end
