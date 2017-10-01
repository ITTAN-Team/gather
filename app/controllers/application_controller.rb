class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource_or_scope)
    events_path
  end

end
