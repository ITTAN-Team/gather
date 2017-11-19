class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # 招待用のイベントID
  @@event_id

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    if params[:event_id].present?
      @@event_id = params[:event_id]
    end
    user = User.validateInvitation(params[:user][:email])
    if user.present?
      respond_to do |format|
        format.html { redirect_to new_user_registration_url, notice: 'Emailが重複しています' }
        format.json { head :no_content }
      end
    else
      if super
        if @@event_id.present? && current_user.present?
          @event_user = EventUser.new(event_id: @@event_id, user_id: current_user.id)
          @event_user.save
        end
      end
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  protected

  def after_update_path_for(resource)
    events_path
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end