class SmtpSettingsController < ApplicationController
  before_action :set_smtp_setting, only: [:show, :edit, :update, :destroy]

  # GET /smtp_settings
  # GET /smtp_settings.json
  def index
    @smtp_settings = current_account.smtp_settings.all
  end

  # GET /smtp_settings/1
  # GET /smtp_settings/1.json
  def show
  end

  # GET /smtp_settings/new
  def new
    @smtp_setting = current_account.smtp_settings.new
  end

  # GET /smtp_settings/1/edit
  def edit
  end

  # POST /smtp_settings
  # POST /smtp_settings.json
  def create
    @smtp_setting = current_account.smtp_settings.new(smtp_setting_params)

    respond_to do |format|
      if @smtp_setting.save
        format.html { redirect_to @smtp_setting, notice: 'Smtp setting was successfully created.' }
        format.json { render :show, status: :created, location: @smtp_setting }
      else
        format.html { render :new }
        format.json { render json: @smtp_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /smtp_settings/1
  # PATCH/PUT /smtp_settings/1.json
  def update
    respond_to do |format|
      if @smtp_setting.update(smtp_setting_params)
        format.html { redirect_to @smtp_setting, notice: 'Smtp setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @smtp_setting }
      else
        format.html { render :edit }
        format.json { render json: @smtp_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /smtp_settings/1
  # DELETE /smtp_settings/1.json
  def destroy
    @smtp_setting.destroy
    respond_to do |format|
      format.html { redirect_to smtp_settings_url, notice: 'Smtp setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_smtp_setting
      @smtp_setting = current_account.smtp_settings.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def smtp_setting_params
      params.require(:smtp_setting).permit(:provider, :address, :port, :username, :password)
    end
end
