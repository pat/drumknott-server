# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Signing up", :type => :feature do
  before :each do
    ActionMailer::Base.deliveries.clear
  end

  it "via email and password" do
    visit root_path
    click_link "Sign up"

    fill_in "Email",            :with => "pat@tuckerapp.com"
    select "Cambodia",          :from => "Country"
    fill_in "user_password",    :with => "mysecret"
    fill_in "Confirm Password", :with => "mysecret"
    click_button "Sign up"

    expect(page).to have_content(
      "A message with a confirmation link has been sent to your email"
    )

    user = User.find_by(:email => "pat@tuckerapp.com")
    expect(user).to_not be_confirmed

    email = emails_sent_to(user.email).detect do |mail|
      mail.subject == "Confirmation instructions"
    end
    expect(email).to be_present

    email.click_link "Confirm my account"

    expect(page).to have_content(
      "Your email address has been successfully confirmed."
    )

    expect(user.reload).to be_confirmed
  end
end
