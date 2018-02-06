class ActivitiesController < ApplicationController
  before_action :set_activities

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

  def set_activities
    @activities = Activity.joins(notification_deliver: :notification)
                          .where('notifications.account_id = ?', current_account.id)
  end
end
