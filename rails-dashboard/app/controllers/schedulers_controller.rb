class SchedulersController < ApplicationController
  respond_to :html

  before_action :set_activity

  def show
    respond_modal_with @activity
  end

  def update
    if %w[canceled pending].include?(params[:status])
      @activity.update(status: params[:status], send_at: Time.current)
    end
    redirect_to activities_path, notice: I18n.t('notifications.flash.success_update')
  end

  private

  def set_activity
    activities = Activity.joins(notification_deliver: :notification)
                         .where('notifications.account_id = ?', current_account.id)

    @activity = activities.find(params[:activity_id])
  end
end
