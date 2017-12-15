class Api::V1::NotificationsController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate
  before_action :check_required_params

  def notify_email
    @notification = @api_account.notifications.friendly.find(params[:id])
    puts params
    email_options = params.except(:action, :controller)
    LambdaEmailNotificationService.new(@notification, email_options).invoke_lambda

    render json: { info: 'success' }, status: :ok
  end

  protected

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @api_account = Account.find_by(api_key: token)
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: { errors: 'Bad credentials' }, status: 401
  end

  private

  def check_required_params
    unless params['email_from'].present?
      render(json: { errors: 'email_from: required' }, status: 422) && return
    end
  end
end
