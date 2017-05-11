class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:nick, :name, :last_name, :email, :password, :password_confirmation, :avatar, :avatar_cache, :remove_avatar)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:nick, :name, :last_name, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar)}
  end 
  def after_sign_out_path_for(resource)
    root_path
  end

  def after_sign_in_path_for(resource)
    timeline_path
  end
end
