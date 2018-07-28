class RegistrationsController < Devise::RegistrationsController

  protected

  def after_sign_up_path_for(resource)
    dashboards_path
  end

  def configure_permitted_parameters
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
