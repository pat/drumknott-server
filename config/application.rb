# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Drumknott
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Settings in config/environments/* take precedence over those specified
    # here. Application configuration should go into files in
    # config/initializers -- all .rb files in that directory are automatically
    # loaded.

    config.middleware.use Rack::Pratchett
    config.middleware.insert 0, Rack::Rewrite do
      r301(
        /.*/,
        "https://#{ENV["DOMAIN_NAME"]}$&",
        :if => lambda { |rack_env|
          rack_env["SERVER_NAME"] == "www.#{ENV["DOMAIN_NAME"]}"
        }
      )
    end if ENV["DOMAIN_NAME"]
  end
end
