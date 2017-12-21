class AccountUser < ApplicationRecord
  belongs_to :account
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :account_id

  def invite
    if !user.invitation_accepted_at.present?
      user.invite!
    else
      # TODO: Notify Email
    end
  end
end
