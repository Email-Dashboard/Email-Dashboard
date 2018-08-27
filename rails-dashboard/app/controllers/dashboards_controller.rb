class DashboardsController < ApplicationController
  def index
    activities = Activity.joins(notification_deliver: :notification)
                         .where(status: 'success')
                         .where('notifications.account_id = ?', current_account.id)

    @sent_emails_count = activities.where("notification_delivers.delivery_method = 'email'").count
  end
end