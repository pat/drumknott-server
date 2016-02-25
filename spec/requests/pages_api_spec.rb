require 'rails_helper'

RSpec.describe 'Pages API', :type => :request do
  let(:site) { Site.make! :name => 'test' }
  let(:json) { JSON.parse response.body }

  describe 'GET /:site/pages' do
    before :each do
      site.pages.create!(
        :name => 'Waffles', :content => 'All the waffles', :path => '/waffles'
      )
      site.pages.create!(
        :name => 'Pancakes', :content => 'And crêpes', :path => '/pancakes'
      )
    end

    it 'returns pages matching the given query for the specified site' do
      get "/api/v1/#{site.name}/pages", :query => 'pancakes'

      expect(json['total']).to eq(1)
      expect(json['results'].first['name']).to eq('Pancakes')
    end

    it 'returns no matches and an error for inactive sites' do
      site.update_attributes :status => 'failure'

      get "/api/v1/#{site.name}/pages", :query => 'pancakes'

      expect(json['total']).to eq(0)
      expect(json['error']).to eq(
        'Site is not active. Please log in to check your account status.'
      )
    end

    it 'returns a 404 when the site does not exist' do
      get '/api/v1/SITE_NAME/pages', :query => 'pancakes'

      expect(response.status).to eq(404)
      expect(json['error']).to eq('Site does not exist')
    end
  end

  describe 'PUT /:site/pages' do
    it 'creates a new page if the details are not yet in the system' do
      put "/api/v1/#{site.name}/pages", {:page =>
        {:name => "Gelato", :path => "/gelato", :contents => "All the gelato"}},
        {'HTTP_AUTHENTICATION' => site.key}

      expect(site.pages.find_by_path('/gelato')).to be_present
    end

    it 'updates an existing page' do
      sorbet = site.pages.create!(
        :name => 'Sorbet', :path => '/sorbet', :content => 'Just sorbet'
      )

      put "/api/v1/#{site.name}/pages", {:page =>
        {:name => "Sorbet", :path => "/sorbet", :content => "Not gelato"}},
        {'HTTP_AUTHENTICATION' => site.key}

      sorbet.reload
      expect(sorbet.content).to eq('Not gelato')
    end

    it 'activates an existing deactivated page' do
      sorbet = site.pages.create!(
        :name => 'Sorbet', :path => '/sorbet', :content => 'Just sorbet',
        :deactivated_at => 1.day.ago
      )

      put "/api/v1/#{site.name}/pages", {:page =>
        {:name => "Sorbet", :path => "/sorbet", :content => "Not gelato"}},
        {'HTTP_AUTHENTICATION' => site.key}

      sorbet.reload
      expect(sorbet).to_not be_deactivated
    end
  end

  describe 'POST /:site/pages/clear' do
    it 'marks all pages attached to the site as deactivated' do
      waffles  = site.pages.create!(
        :name => 'Waffles', :content => 'All the waffles', :path => '/waffles'
      )
      pancakes = site.pages.create!(
        :name => 'Pancakes', :content => 'And crêpes', :path => '/pancakes'
      )

      post "/api/v1/#{site.name}/pages/clear", {},
        {'HTTP_AUTHENTICATION' => site.key}

      waffles.reload
      pancakes.reload

      expect(waffles).to be_deactivated
      expect(pancakes).to be_deactivated
    end
  end
end
