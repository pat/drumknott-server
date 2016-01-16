class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  expose(:section) { 'home' }

  before_filter :configure_permitted_parameters, :if => :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    my_dashboard_path
  end

  def after_sign_up_path_for(resource)
    my_dashboard_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :country
  end
end
