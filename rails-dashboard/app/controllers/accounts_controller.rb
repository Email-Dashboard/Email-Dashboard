class AccountsController < ApplicationController
  before_action :set_account, only: [:edit, :update, :set_current, :destroy]
  before_action :check_owner_access, only: [:edit, :update, :destroy]

  include BreadcrumbExtension

  def index
    @accounts = current_user.accounts
  end

  def new
    @account = current_user.accounts.new
  end

  def edit
    add_breadcrumb @account.name
    super
  end

  def create
    current_user.setup_account(account_params[:name])
    respond_to do |format|
      format.html { redirect_to accounts_path, notice: I18n.t('accounts.flash.successfully_created') }
    end
  end

  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to edit_account_path(@account), notice: I18n.t('accounts.flash.successfully_updated') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if !@account.notifications.present? && @account.destroy
        format.html { redirect_to accounts_url, notice: I18n.t('accounts.flash.successfully_destroyed') }
      else
        format.html { redirect_to accounts_url, flash: { error: I18n.t('accounts.flash.can_not_destroy') } }
      end
    end
  end

  def set_current
    session[:current_account_id] = @account.id
    redirect_to root_path
  end

  private

  def check_owner_access
    if current_user.role_in_account(@account) != 'owner'
      redirect_to(accounts_path, flash: { error: I18n.t('accounts.flash.no_access') }) && return
    end
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = current_user.accounts.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:name, :live_mode, :to_email_for_test)
  end
end
