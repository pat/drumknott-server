# frozen_string_literal: true

class My::DashboardController < My::ApplicationController
  expose(:section) { "dashboard" }
end
