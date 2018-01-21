class ActivitiesController < ApplicationController

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.includes(notification_deliver: { notification: :account })
                          .where(notification_delivers: { notifications: { account_id: current_account.id }})
                          .order(created_at: :desc).page(params[:page])
  end
end
