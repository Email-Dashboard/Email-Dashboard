class ActivitiesController < ApplicationController
  before_action :set_activities
  before_action :authorize_view_token, only: :show

  # GET /activities
  # GET /activities.json
  def index
    add_breadcrumb ''
    @activities = @activities.order(created_at: :desc).page(params[:page])
  end

  def show
    @activity = @activities.find(params[:id])
    add_breadcrumb @activity.id

    content = JSON.parse(@activity.request_content)
    template = @activity.notification_deliver.notification_content.content

    handlebars = Handlebars::Context.new
    email_template = handlebars.compile(template)
    @activity_content = email_template.call(content)

    respond_to do |format|
      format.html { render 'activities/show', layout: false }
    end
  end

  private

  def authorize_view_token
    if params[:token].present?
      decoded_token = JWT.decode params[:token], nil, false

      # View token expires in 15 minutes
      if Time.current > (Time.at(decoded_token.first['data']) + 15.minutes)
        redirect_to activities_path, flash: { error: 'View token expired! Please try again...' }
        return
      end
    else
      redirect_to activities_path, flash: { error: 'View token required!' }
      return
    end
  end

  def set_activities
    @activities = Activity.joins(notification_deliver: :notification)
                          .where('notifications.account_id = ?', current_account.id)
  end
end
