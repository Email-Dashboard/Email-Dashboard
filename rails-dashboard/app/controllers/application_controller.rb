class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout_by_resource

  before_action :authenticate_user!
  before_action :check_current_account, if: :user_signed_in?
  helper_method :current_account

  add_breadcrumb I18n.t('dashboard.home.title'), :root_path

  def current_account
    @current_account ||= current_user.accounts.find_by(id: session[:current_account_id]) || current_user.accounts.first
  end

  def respond_modal_with(*args, &blk)
    options = args.extract_options!
    options[:responder] = ModalResponder
    respond_with *args, options, &blk
  end

  private

  def check_current_account
    return if devise_controller?
    if !current_account.present? && controller_name != 'accounts'
      redirect_to accounts_path
    end
  end

  def layout_by_resource
    if devise_controller? && !(controller_name == 'registrations' && action_name == 'edit')
      'devise'
    else
      'application'
    end
  end
end
