# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.6.5"

# rails
gem "rails", "6.0.2.2"

# core
gem "pg",      "~> 1.0"
gem "puma",    "~> 4.0"
gem "sidekiq", "6.0.7"

# assets gems
gem "coffee-rails", "~> 5.0.0"
gem "jquery-rails"
gem "sass-rails", "~> 6.0"
gem "turbolinks"
gem "uglifier", ">= 1.3.0"

# everything else
gem "bugsnag",         "~> 6.13.0"
gem "country_select",  "~> 4.0.0"
gem "decent_exposure", "~> 3.0"
gem "devise",          "~> 4.4"
gem "flying-sphinx",   "~> 2.0"
gem "formtastic",      "~> 3.1.3"
gem "haml",            "5.1.2"
gem "kaminari",        "~> 1.2.0"
gem "mysql2",          "~> 0.5.0"
gem "newrelic_rpm",    "~> 6.0"
gem "prawn",           "~> 2.0"
gem "prawn-table",     "~> 0.2.2"
gem "rack-pratchett",  "~> 0.1.1"
gem "rack-rewrite",    "~> 1.5.1"
gem "rack-timeout",    "~> 0.3"
gem "rubocop",         "~> 0.82.0"
gem "rubocop-performance"
gem "rubocop-rails"
gem "sliver-rails",    "~> 0.2.0"
gem "stripe",          "~> 5.21.0"
gem "stripe_event",    "~> 2.3.0"
gem "thinking-sphinx", "~> 4.4"

group :development do
  gem "byebug"
  gem "web-console", "~> 4.0"
end

group :development, :test do
  gem "dotenv-rails", "~> 2.7.0"
  gem "rspec-rails"
  gem "spring"
  gem "thinking-sphinx-ports", "~> 0.1.0"
end

group :test do
  gem "capybara",  "3.32.1"
  gem "machinist", "~> 2.0",
    :git    => "https://github.com/pat/machinist.git",
    :branch => "master",
    :ref    => "ff04f1a92d"
  gem "vcr",           "~> 5.0"
  gem "vcr_assistant", "~> 1.0"
  gem "webmock",       "~> 3.8.0"
end

group :production do
  gem "rails_12factor"
end
