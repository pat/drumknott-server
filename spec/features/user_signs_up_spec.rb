require 'rails_helper'

RSpec.describe 'Signing up', :type => :feature do
  before :each do
    ActionMailer::Base.deliveries.clear
  end

  it 'via email and password' do
    visit root_path
    click_link 'Sign up'

    fill_in 'Email',            :with => 'pat@tuckerapp.com'
    select 'Cambodia',          :from => 'Country'
    fill_in 'user_password',    :with => 'mysecret'
    fill_in 'Confirm Password', :with => 'mysecret'
    click_button 'Sign up'

    expect(page).to have_content('You have signed up successfully')
    expect(page).to have_content('Log out')
  end
end
