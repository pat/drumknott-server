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
end
