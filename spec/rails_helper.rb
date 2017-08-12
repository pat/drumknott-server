require 'spec_helper'
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'sidekiq/testing/inline'
require 'webmock/rspec'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }

ActiveRecord::Migration.maintain_test_schema!

if ENV["SPHINX_BIN"]
  ThinkingSphinx::Configuration.instance.controller.bin_path = ENV['SPHINX_BIN']
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.before :each do |example|
    if example.metadata[:type] == :request
      ThinkingSphinx::Test.init
      ThinkingSphinx::Test.start index: false
    end

    ThinkingSphinx::Configuration.instance.settings['real_time_callbacks'] =
      (example.metadata[:type] == :request)
  end

  config.after(:each) do |example|
    if example.metadata[:type] == :request
      ThinkingSphinx::Test.stop
      ThinkingSphinx::Test.clear
    end
  end
end
