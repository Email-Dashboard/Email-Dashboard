class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  include BreadcrumbExtension

  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = current_account.notifications.all
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
    add_breadcrumb @notification.name, notification_path(@notification)

    @activities = Activity.where(notification_deliver_id: @notification.email_deliver.id)
                          .order('created_at desc').page(params[:page])
  end

  # GET /notifications/new
  def new
    @notification = current_account.notifications.new
  end

  # GET /notifications/1/edit
  def edit
    add_breadcrumb @notification.name, notification_path(@notification)
    super
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = current_account.notifications.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /notifications/1
  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = current_account.notifications.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require(:notification).permit(:name)
    end
end
