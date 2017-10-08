class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    events_path
  end

  def after_sign_up_path_for(resource)
    events_path
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
