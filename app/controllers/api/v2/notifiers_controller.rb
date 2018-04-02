class Api::V2::NotifiersController < Api::V2::ApiBaseController
  before_action :check_required_params

  def create
    @notification = @api_account.notifications.friendly.find(params[:notification_id])
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
    param! :email, Hash do |e|
      e.param! :to, Array, required: true
      e.param! :from, String, required: true
    end

    param! :sms, Hash do |e|
      e.param! :to, Array, required: true
    end

    param! :delivery, Hash do |e|
      e.param! :time, String, required: true, format: /\d{2}:\d{2}/
      e.param! :date, String, required: true, format: /\d{4}-\d{2}-\d{2}/
    end
  rescue RailsParam::Param::InvalidParameterError => e
    render(json: { errors: e }, status: 422) && return
  end

  def enqueue_email_job
    if params['delivery'].present?

      time_zone = params['delivery']['time_zone'] || 'UTC'
      zone = ActiveSupport::TimeZone.all.collect(&:name).include?(time_zone) ? time_zone : 'UTC'

      # ActiveSupport::TimeZone[zone].parse("2018-02-07 21:00:00").utc
      send_at = ActiveSupport::TimeZone[zone].parse("#{params['delivery']['date']} #{params['delivery']['time']}").utc

      Activity.create(
        notification_deliver: @notification.email_deliver,
        request_content: params.to_json, send_at: send_at,
        status: 'scheduled'
      )
      # LambdaEmailDeliverJob.set(wait_until: send_at).perform_later(params.to_json, @notification.email_deliver.id)
    else
      Activity.create(
        notification_deliver: @notification.email_deliver,
        request_content: params.to_json, send_at: Time.current,
        status: 'pending'
      )
    end
  end
end
