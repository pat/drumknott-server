# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Signing in", :type => :feature do
  let(:user) do
    User.create!(
      :email        => "pat@tuckerapp.com",
      :password     => "mysecret",
      :confirmed_at => 1.second.ago
    )
  end

  it "via email and password" do
    visit root_path
    click_link "Log in"

    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("Log out")
  end
end
