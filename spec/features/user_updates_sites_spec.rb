# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Updating sites', :type => :feature do
  let(:user) { User.make! }
  let(:site) { Site.make! user: user }

  before :each do
    sign_in_as user
  end

  it 'updates site name' do
    visit my_site_path(site)

    fill_in 'Name', with: 'new-name'
    click_button 'Update Site'

    site.reload
    expect(site.name).to eq('new-name')
  end

  it 'regenerates the site key' do
    old_key = site.key

    visit my_site_path(site)
    click_link 'generate a new key'

    new_key = site.reload.key
    expect(new_key).to be_present
    expect(new_key).to_not eq(old_key)
    expect(page).to have_content(new_key)
  end
end
