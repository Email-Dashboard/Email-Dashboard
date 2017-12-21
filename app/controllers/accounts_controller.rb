class AccountsController < ApplicationController
  before_action :set_account, only: [:edit, :update, :set_current, :destroy]

  def index
    @accounts = current_user.accounts
  end

  def new
    @account = current_user.accounts.new
  end

  def edit
  end

  def create
    current_user.setup_account(account_params[:name])
    respond_to do |format|
      format.html { redirect_to accounts_path, notice: 'Account was successfully created.' }
    end
  end

  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if !@account.notifications.present? && @account.destroy
        format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      else
        format.html { redirect_to accounts_url, flash: { error: 'Account cant delete! Has notifications!' } }
      end
    end
  end

  def set_current
    session[:current_account_id] = @account.id
    redirect_to root_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = current_user.accounts.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:name)
  end
end
