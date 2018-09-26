class InvitationsController < ApplicationController

    def create
      require 'securerandom'

      @user = User.find_by(email: params[:invitation][:email])
      account = Account.find(params[:invitation][:account])

      unless @user.present?
        passwd = SecureRandom.hex(8)

        @user = User.create(email: params[:invitation][:email],
                            password: passwd,
                            password_confirmation: passwd)
      end

      @account_user = AccountUser.create!(user_id: @user.id, account_id: account.id)
      @account_user.invite

      redirect_to edit_account_path(account), notice: I18n.t('accounts.flash.invitation_sent')
    end

    def update
      account = Account.find(params[:account_id])
      account_user = account.account_users.find(params[:id])
      account_user.invite
      redirect_to edit_account_path(account), notice: I18n.t('accounts.flash.invitation_sent')
    end
end
