class TrackingsController < ApplicationController
  include BreadcrumbExtension

  def show
    @account = current_account
  end

  def update
    respond_to do |format|
      if current_account.update(account_params)
        format.html { redirect_to trackings_path, notice: 'Account was successfully updated.' }
      else
        format.html { render :show }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:sns_access_key, :sns_secret_key, :sns_region)
  end
end
