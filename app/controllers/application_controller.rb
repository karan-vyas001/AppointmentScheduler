class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role_ids, :organization_id, :first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role_ids, :organization_id, :first_name, :last_name])
  end
end
