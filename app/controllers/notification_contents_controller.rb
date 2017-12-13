class NotificationContentsController < ApplicationController
  before_action :set_notification_content, only: [:show, :edit, :update, :destroy]

  # GET /notification_contents
  # GET /notification_contents.json
  def index
    @notification_contents = current_account.notification_contents.all
  end

  # GET /notification_contents/1
  # GET /notification_contents/1.json
  def show
  end

  # GET /notification_contents/new
  def new
    @notification_content = current_account.notification_contents.new
  end

  # GET /notification_contents/1/edit
  def edit
  end

  # POST /notification_contents
  # POST /notification_contents.json
  def create
    @notification_content = current_account.notification_contents.new(notification_content_params)

    respond_to do |format|
      if @notification_content.save
        format.html { redirect_to @notification_content, notice: 'Notification content was successfully created.' }
        format.json { render :show, status: :created, location: @notification_content }
      else
        format.html { render :new }
        format.json { render json: @notification_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notification_contents/1
  # PATCH/PUT /notification_contents/1.json
  def update
    respond_to do |format|
      if @notification_content.update(notification_content_params)
        format.html { redirect_to @notification_content, notice: 'Notification content was successfully updated.' }
        format.json { render :show, status: :ok, location: @notification_content }
      else
        format.html { render :edit }
        format.json { render json: @notification_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notification_contents/1
  # DELETE /notification_contents/1.json
  def destroy
    @notification_content.destroy
    respond_to do |format|
      format.html { redirect_to notification_contents_url, notice: 'Notification content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification_content
      @notification_content = current_account.notification_contents.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_content_params
      params.require(:notification_content).permit(:name, :content)
    end
end
