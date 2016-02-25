require 'rails_helper'

RSpec.describe RemoveDeactivatedPages do
  let(:site) { Site.make! }

  it 'deletes pages that have been deactivated for more than a day' do
    page = site.pages.create! :name => 'Gelato', :path => '/gelato',
      :deactivated_at => 25.hours.ago

    RemoveDeactivatedPages.call

    expect(Page.find_by(:id => page.id)).to be_nil
  end

  it 'keeps pages that have been deactivated for less than a day' do
    page = site.pages.create! :name => 'Gelato', :path => '/gelato',
      :deactivated_at => 23.hours.ago

    RemoveDeactivatedPages.call

    expect(Page.find_by(:id => page.id)).to be_present
  end

  it 'keeps active pages' do
    page = site.pages.create! :name => 'Gelato', :path => '/gelato',
      :deactivated_at => nil

    RemoveDeactivatedPages.call

    expect(Page.find_by(:id => page.id)).to be_present
  end
end
