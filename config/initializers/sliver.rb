# frozen_string_literal: true

require "new_relic/agent/instrumentation"
require "new_relic/agent/instrumentation/controller_instrumentation"

module Sliver::NewRelic
  include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation

  def call(environment)
    request = ::Rack::Request.new environment
    trace_options = {
      :category => :rack,
      :path     => "#{name}/call",
      :request  => request,
      :params   => request.params
    }
    perform_action_with_newrelic_trace(trace_options) { super }
  end
end

module Sliver::Action
  def self.included(base)
    base.extend Sliver::Action::ClassMethods
    base.extend Sliver::NewRelic
  end
end

Sliver::Rails::Action.extend Sliver::NewRelic
