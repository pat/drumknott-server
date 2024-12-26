# frozen_string_literal: true

source "https://rubygems.org"

ruby :file => ".tool-versions"

# rails
gem "rails", "~> 8.0"
gem "sprockets-rails"

# core
gem "pg",      "~> 1.0"
gem "puma",    "~> 6.4"
gem "sidekiq", "7.3.7"

# assets gems
gem "coffee-rails", "~> 5.0.0"
gem "jquery-rails"
gem "sass-rails", "~> 6.0"
gem "terser"
gem "turbolinks"

# everything else
gem "bugsnag",         "~> 6.27.0"
gem "country_select",  "~> 10.0.0"
gem "decent_exposure", "~> 3.0"
gem "devise",          "~> 4.4"
gem "flying-sphinx",   "~> 3.0"
gem "formtastic",      "~> 5.0",
  :git    => "https://github.com/leoarnold/formtastic.git",
  :branch => "leoarnold/fix/country_input",
  :ref    => "17143b97"
gem "haml",            "6.3.0"
gem "kaminari",        "~> 1.2.0"
gem "matrix"
gem "mysql2",          "~> 0.5.0",
  :git    => "https://github.com/pat/mysql2.git",
  :branch => "frozen-string-builds"
gem "newrelic_rpm",    "~> 9.0"
gem "nokogiri",        "~> 1.18.0"
gem "prawn",           "~> 2.0"
gem "prawn-table",     "~> 0.2.2"
gem "rack-pratchett",  "~> 0.1.1"
gem "rack-rewrite",    "~> 1.5.1"
gem "rack-timeout",    "~> 0.3",
  :git    => "https://github.com/mitchellhenke/rack-timeout.git",
  :branch => "ensure-mutable-string",
  :ref    => "c0845b37"
gem "rubocop",         "~> 1.7"
gem "rubocop-performance"
gem "rubocop-rails"
gem "sliver-rails",    "~> 0.2.0"
gem "stripe",          "~> 13.3.0"
gem "stripe_event",    "~> 2.11.0"
gem "thinking-sphinx", "~> 5.0"

group :development do
  gem "byebug"
  gem "web-console", "~> 4.0"
end

group :development, :test do
  gem "dotenv-rails", "~> 3.1.0"
  gem "rspec-rails"
  gem "thinking-sphinx-ports", "~> 0.1.0"
end

group :test do
  gem "capybara", "3.40.0"
  gem "capybara-email"
  gem "machinist", "~> 2.0",
    :git    => "https://github.com/pat/machinist.git",
    :branch => "master",
    :ref    => "ff04f1a92d"
  gem "rspec-github", :require => false
  gem "rubocop-github-annotations-formatter", :require => false
  gem "vcr",           "~> 6.0"
  gem "vcr_assistant", "~> 1.0"
  gem "webmock",       "~> 3.24.0"
end

group :production do
  gem "rails_12factor"
end
