# frozen_string_literal: true

workers Integer(ENV.fetch("WEB_CONCURRENCY", 2))
threads_count = Integer(ENV.fetch("MAX_THREADS", 5))
threads threads_count, threads_count

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
#
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

port        Integer(ENV.fetch("PORT", 3000))
environment ENV.fetch("RACK_ENV", "development")
pidfile     ENV.fetch("PIDFILE", "tmp/pids/server.pid")

plugin :tmp_restart
