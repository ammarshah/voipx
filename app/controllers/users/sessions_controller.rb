class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  protected
    def after_sign_in_path_for(resource)
      if resource.has_role?(:admin)
        admin_dashboard_path
      else
        if resource.sign_in_count == 1
          edit_user_path(resource, is_first_login: "yes")
        else
          request.env['omniauth.origin'] || stored_location_for(resource) || dashboard_path
        end
      end
    end
end
