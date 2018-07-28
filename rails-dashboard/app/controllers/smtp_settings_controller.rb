class SmtpSettingsController < ApplicationController
  before_action :set_smtp_setting, only: [:show, :edit, :update, :destroy]

  include BreadcrumbExtension

  # GET /smtp_settings
  # GET /smtp_settings.json
  def index
    @smtp_settings = current_account.smtp_settings.all
  end

  # GET /smtp_settings/1
  # GET /smtp_settings/1.json
  def show
    add_breadcrumb @smtp_setting.provider, smtp_setting_path(@smtp_setting)
  end

  # GET /smtp_settings/new
  def new
    @smtp_setting = current_account.smtp_settings.new
  end

  # GET /smtp_settings/1/edit
  def edit
    add_breadcrumb @smtp_setting.provider, smtp_setting_path(@smtp_setting)
    super
  end

  # POST /smtp_settings
  # POST /smtp_settings.json
  def create
    @smtp_setting = current_account.smtp_settings.new(smtp_setting_params)

    respond_to do |format|
      if @smtp_setting.save
        format.html { redirect_to smtp_settings_url, notice: 'Smtp setting was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /smtp_settings/1
  # PATCH/PUT /smtp_settings/1.json
  def update
    respond_to do |format|
      if @smtp_setting.update(smtp_setting_params)
        format.html { redirect_to smtp_settings_url, notice: 'Smtp setting was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /smtp_settings/1
  # DELETE /smtp_settings/1.json
  def destroy
    @smtp_setting.destroy
    respond_to do |format|
      format.html { redirect_to smtp_settings_url, notice: 'Smtp setting was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_smtp_setting
      @smtp_setting = current_account.smtp_settings.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def smtp_setting_params
      params.require(:smtp_setting).permit(:provider, :address, :port, :username, :password, :aws_region)
    end
end
