class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :check_current_account, if: :user_signed_in?
  helper_method :current_account

  add_breadcrumb 'Home', :root_path

  def current_account
    @current_account ||= current_user.accounts.find_by(id: session[:current_account_id]) || current_user.accounts.first
  end

  private

  def check_current_account
    return if devise_controller?
    if !current_account.present? && controller_name != 'accounts'
      redirect_to accounts_path
    end
  end
end
