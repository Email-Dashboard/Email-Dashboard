class NotificationDeliversController < ApplicationController
  before_action :set_notification
  before_action :set_deliver

  def update
    if @deliver.update(notification_deliver_params)
      redirect_to notification_path(@notification), flash: { success: I18n.t('notifications.flash.success_update') }
    else
      redirect_to notification_path(@notification), flash: { error: I18n.t('notifications.flash.smtp_required') }
    end
  end

  private

  def notification_deliver_params
    params.require(:notification_deliver).permit(:is_active, :notification_content_id, :smtp_setting_id)
  end

  def set_deliver
    @deliver = @notification.notification_delivers.find(params[:id])
  end

  def set_notification
    @notification = current_account.notifications.friendly.find(params[:notification_id])
  end
end
