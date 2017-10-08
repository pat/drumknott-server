# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :exception

  expose(:section) { "home" }

  before_action :configure_permitted_parameters, :if => :devise_controller?

  protected

  def after_sign_in_path_for(_resource)
    my_dashboard_path
  end

  def after_sign_up_path_for(_resource)
    my_dashboard_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, :keys => [:country]
  end
end
