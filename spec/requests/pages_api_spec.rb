require 'rails_helper'

RSpec.describe 'Pages API', :type => :request do
  let(:site) { Site.create! :name => 'test' }
  let(:json) { JSON.parse response.body }

  describe 'GET /:site/pages' do
    it 'returns pages matching the given query for the specified site' do
      waffles  = site.pages.create!(
        :name => 'Waffles', :content => 'All the waffles', :path => '/waffles'
      )
      pancakes = site.pages.create!(
        :name => 'Pancakes', :content => 'And crêpes', :path => '/pancakes'
      )

      get "/api/v1/#{site.name}/pages", :query => 'pancakes'

      expect(json['total']).to eq(1)
      expect(json['results'].first['name']).to eq('Pancakes')
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
  end

  describe 'POST /:site/pages/clear' do
    it 'deletes all pages attached to the site' do
      waffles  = site.pages.create!(
        :name => 'Waffles', :content => 'All the waffles', :path => '/waffles'
      )
      pancakes = site.pages.create!(
        :name => 'Pancakes', :content => 'And crêpes', :path => '/pancakes'
      )

      post "/api/v1/#{site.name}/pages/clear", {},
        {'HTTP_AUTHENTICATION' => site.key}

      expect(site.pages.count).to be_zero
    end
  end
end
