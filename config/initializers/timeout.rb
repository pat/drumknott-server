# frozen_string_literal: true

Rails.application.config.middleware.insert_before Rack::Runtime, Rack::Timeout,
  :service_timeout => 5
