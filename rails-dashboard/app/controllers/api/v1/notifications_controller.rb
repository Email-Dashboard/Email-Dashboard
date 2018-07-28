class Api::V1::NotificationsController < ActionController::Base

  def notify_email
    render json: { errors: 'DEPRECATED!: Use V2' }, status: 422
  end
end
