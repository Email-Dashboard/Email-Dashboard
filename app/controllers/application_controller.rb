class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_account

  def current_account
    @current_account ||= Account.first
  end
end
