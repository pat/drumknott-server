# frozen_string_literal: true

workers Integer(ENV.fetch("WEB_CONCURRENCY", 2))
threads_count = Integer(ENV.fetch("MAX_THREADS", 5))
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        Integer(ENV.fetch("PORT", 3000))
environment ENV.fetch("RACK_ENV", "development")

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end

plugin :tmp_restart
