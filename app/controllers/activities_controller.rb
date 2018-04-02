class ActivitiesController < ApplicationController
  before_action :set_activities, :set_custom_breadcrumbs
  before_action :authorize_view_token, only: :show

  def index
    @q = @activities.ransack(params[:q])
    @q.sorts = 'created_at DESC'
    @list_activities = @q.result(distinct: true).page(params[:page])
  end

  def show
    @activity = @activities.find(params[:id])
    add_breadcrumb @activity.id

    content  = JSON.parse(@activity.request_content)
    template = @activity.notification_deliver.notification_content.content
    subject  = @activity.notification_deliver.notification_content.subject

    handlebars = Handlebars::Context.new
    email_template = handlebars.compile(template)

    @activity_variables = email_template.call(content['variables'])

    email_subject = handlebars.compile(subject)
    @activity_subject = email_subject.call(content['variables'])

    @activity_email   = content['email']

    respond_to do |format|
      format.html { render 'activities/show', layout: false }
    end
  end

  private

  def set_custom_breadcrumbs
    add_breadcrumb 'Activities', activities_path
  end

  def authorize_view_token
    if params[:token].present?
      decoded_token = JWT.decode params[:token], nil, false

      # View token expires in 15 minutes
      if Time.current > (Time.at(decoded_token.first['data']) + 15.minutes)
        redirect_to activities_path, flash: { error: 'View token expired! Please try again...' }
      end
    else
      redirect_to activities_path, flash: { error: 'View token required!' }
    end
  end

  def set_activities
    @activities = Activity.joins(notification_deliver: :notification)
                          .where('notifications.account_id = ?', current_account.id)
  end
end
