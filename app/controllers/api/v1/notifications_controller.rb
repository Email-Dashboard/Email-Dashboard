class Api::V1::NotificationsController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods  

  before_action :authenticate

  def notify
    @notification = @api_account.notifications.friendly.find(params[:id])
    puts @notification.name
    render json: { info: 'ok' }, status: :ok
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
end
