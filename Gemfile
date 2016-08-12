source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails',   '4.2.7.1'
gem 'pg'
gem 'puma',    '3.6.0'
gem 'sidekiq', '3.3.4'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'

gem 'bugsnag',         '~> 3.0.0'
gem 'country_select',  '~> 2.5.1'
gem 'devise',          '3.5.2'
gem 'decent_exposure', '2.3.2'
gem 'formtastic',      '3.1.3'
gem 'haml',            '4.0.7'
gem 'kaminari',        '~> 0.16.3'
gem 'newrelic_rpm',    '~> 3.14.1.311'
gem 'mysql2',          '0.3.18'
gem 'prawn',           '~> 2.0.2'
gem 'prawn-table',     '~> 0.2.2'
gem 'rack-pratchett',  '~> 0.1.1'
gem 'rack-timeout',    '~> 0.3.2'
gem 'sinatra',         '~> 1.4.6', :require => nil
gem 'sliver-rails',    '0.2.0'
gem 'stripe',          '~> 1.32.1'
gem 'stripe_event',    '~> 1.5.0'
gem 'thinking-sphinx', '3.1.4'
gem 'flying-sphinx',   '1.2.0'

group :development do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'dotenv-rails', '~> 2.0.2'
  gem 'rspec-rails'
  gem 'spring'
end

group :test do
  gem 'capybara',  '2.5.0'
  gem 'machinist', '~> 2.0'
  gem 'vcr',       '~> 3.0.1'
  gem 'vcr_assistant', '~> 0.1.1',
    :require => 'vcr_assistant/rspec'
  gem 'webmock',   '~> 1.22.5'
end

group :production do
  gem 'rails_12factor'
end
