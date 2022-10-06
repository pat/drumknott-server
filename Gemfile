# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.0.4"

# rails
gem "rails", "~> 7.0"
gem "sprockets-rails"

# core
gem "pg",      "~> 1.0"
gem "puma",    "~> 5.6"
gem "sidekiq", "6.5.7"

# assets gems
gem "coffee-rails", "~> 5.0.0"
gem "jquery-rails"
gem "sass-rails", "~> 6.0"
gem "turbolinks"
gem "uglifier", ">= 1.3.0"

# everything else
gem "bugsnag",         "~> 6.24.0"
gem "country_select",  "~> 8.0.0"
gem "decent_exposure", "~> 3.0"
gem "devise",          "~> 4.4"
gem "flying-sphinx",   "~> 3.0"
gem "formtastic",      "~> 4.0"
gem "haml",            "6.0.5"
gem "kaminari",        "~> 1.2.0"
gem "mysql2",          "~> 0.5.0"
gem "newrelic_rpm",    "~> 8.0"
gem "prawn",           "~> 2.0"
gem "prawn-table",     "~> 0.2.2"
gem "rack-pratchett",  "~> 0.1.1"
gem "rack-rewrite",    "~> 1.5.1"
gem "rack-timeout",    "~> 0.3"
gem "rubocop",         "~> 1.7"
gem "rubocop-performance"
gem "rubocop-rails"
gem "sliver-rails",    "~> 0.2.0"
gem "stripe",          "~> 7.1.0"
gem "stripe_event",    "~> 2.6.0"
gem "thinking-sphinx", "~> 5.0"

group :development do
  gem "byebug"
  gem "web-console", "~> 4.0"
end

group :development, :test do
  gem "dotenv-rails", "~> 2.8.1"
  gem "rspec-rails"
  gem "thinking-sphinx-ports", "~> 0.1.0"
end

group :test do
  gem "capybara", "3.37.1"
  gem "capybara-email"
  gem "machinist", "~> 2.0",
    :git    => "https://github.com/pat/machinist.git",
    :branch => "master",
    :ref    => "ff04f1a92d"
  gem "vcr",           "~> 6.0"
  gem "vcr_assistant", "~> 1.0"
  gem "webmock",       "~> 3.18.1"
end

group :production do
  gem "rails_12factor"
end
