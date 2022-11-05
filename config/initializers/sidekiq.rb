# frozen_string_literal: true

redis_config = {
  :url             => ENV.fetch("REDIS_URL"),
  :network_timeout => 5,
  :ssl_params      => {:verify_mode => OpenSSL::SSL::VERIFY_NONE}
}

Sidekiq.configure_server { |config| config.redis = redis_config }
Sidekiq.configure_client { |config| config.redis = redis_config }
