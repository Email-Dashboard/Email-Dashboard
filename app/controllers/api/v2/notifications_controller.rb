class Api::V2::NotificationsController < Api::V2::ApiBaseController
  before_action :check_required_params

  def notify_email
    @notification = @api_account.notifications.friendly.find(params[:id])
    email_options = params.except(:action, :controller)

    if @notification.email_deliver.is_active
      enqueue_email_job
      render json: { info: 'success' }, status: :ok
    else
      render json: { errors: 'Notification inactive' }, status: 422
    end
  end

  private

  def check_required_params
    unless params['email'].present?
      render(json: { errors: 'email data required' }, status: 422) && return
    end
  end

  def enqueue_email_job
    if params['delivery'].present? && params['delivery']['time'].present? && params['delivery']['date'].present?

      time_zone = params['delivery']['time_zone'] || 'UTC'
      zone = ActiveSupport::TimeZone.all.collect(&:name).include?(time_zone) ? time_zone : 'UTC'

      # ActiveSupport::TimeZone[zone].parse("2018-02-07 21:00:00").utc
      send_at = ActiveSupport::TimeZone[zone].parse("#{params['delivery']['date']} #{params['delivery']['time']}").utc

      LambdaEmailDeliverJob.set(wait_until: send_at).perform_later(params.to_json)
    else
      LambdaEmailDeliverJob.perform_later(params.to_json)
    end
  end
end
