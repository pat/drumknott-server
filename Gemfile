# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.6.3"

# rails
gem "rails", "5.2.3"

# core
gem "pg",      "~> 1.0"
gem "puma",    "~> 3.10"
gem "sidekiq", "5.2.7"

# assets gems
gem "coffee-rails", "~> 5.0.0"
gem "jquery-rails"
gem "sass-rails", "~> 5.0"
gem "turbolinks"
gem "uglifier", ">= 1.3.0"

# everything else
gem "bugsnag",         "~> 6.11.0"
gem "country_select",  "~> 4.0.0"
gem "decent_exposure", "~> 3.0"
gem "devise",          "~> 4.4"
gem "flying-sphinx",   "~> 2.0"
gem "formtastic",      "~> 3.1.3"
gem "haml",            "5.1.0"
gem "kaminari",        "~> 1.1.0"
gem "mysql2",          "~> 0.5.0"
gem "newrelic_rpm",    "~> 6.0"
gem "prawn",           "~> 2.0"
gem "prawn-table",     "~> 0.2.2"
gem "rack-pratchett",  "~> 0.1.1"
gem "rack-rewrite",    "~> 1.5.1"
gem "rack-timeout",    "~> 0.3"
gem "rubocop",         "~> 0.69.0"
gem "sliver-rails",    "~> 0.2.0"
gem "stripe",          "~> 4.17.0"
gem "stripe_event",    "~> 2.2.0"
gem "thinking-sphinx", "~> 4.0"

group :development do
  gem "byebug"
  gem "web-console", "~> 3.5"
end

group :development, :test do
  gem "dotenv-rails", "~> 2.7.0"
  gem "rspec-rails"
  gem "spring"
  gem "thinking-sphinx-ports", "~> 0.1.0"
end

group :test do
  gem "capybara",  "3.20.0"
  gem "machinist", "~> 2.0",
    :git    => "https://github.com/pat/machinist.git",
    :branch => "master",
    :ref    => "ff04f1a92d"
  gem "vcr",           "~> 4.0"
  gem "vcr_assistant", "~> 1.0"
  gem "webmock",       "~> 3.5.1"
end

group :production do
  gem "rails_12factor"
end
