source 'https://rubygems.org'

ruby '2.4.2'

gem 'rails',   '5.1.4'
gem 'pg'
gem 'puma',    '3.10.0'
gem 'sidekiq', '5.0.4'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2.2'
gem 'jquery-rails'
gem 'turbolinks'

gem 'bugsnag',         '~> 5.3.0'
gem 'country_select',  '~> 3.1.1'
gem 'devise',          '4.3.0'
gem 'decent_exposure', '~> 3.0'
gem 'formtastic',      '~> 3.1.3'
gem 'haml',            '5.0.3'
gem 'kaminari',        '~> 0.16.3'
gem 'newrelic_rpm',    '~> 4.5.0.337'
gem 'mysql2',          '0.4.9'
gem 'prawn',           '~> 2.0.2'
gem 'prawn-table',     '~> 0.2.2'
gem 'rack-pratchett',  '~> 0.1.1'
gem 'rack-rewrite',    '~> 1.5.1'
gem 'rack-timeout',    '~> 0.3.2'
gem 'sliver-rails',    '0.2.0'
gem 'stripe',          '~> 3.3.0'
gem 'stripe_event',    '~> 1.8.0'
gem 'thinking-sphinx', '3.4.2'
gem 'flying-sphinx',   '1.2.1'

group :development do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'dotenv-rails', '~> 2.2.1'
  gem 'rspec-rails'
  gem 'spring'
  gem 'thinking-sphinx-ports', '~> 0.1.0'
end

group :test do
  gem 'capybara',  '2.15.2'
  gem 'machinist', '~> 2.0',
    :git    => 'https://github.com/pat/machinist.git',
    :branch => 'master',
    :ref    => 'ff04f1a92d'
  gem 'vcr',       '~> 3.0.1'
  gem 'vcr_assistant', '~> 0.1.1',
    :require => 'vcr_assistant/rspec'
  gem 'webmock',   '~> 3.0.1'
end

group :production do
  gem 'rails_12factor'
end
