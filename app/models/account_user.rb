# == Schema Information
#
# Table name: account_users
#
#  id         :integer          not null, primary key
#  account_id :integer
#  user_id    :integer
#  role       :string(255)      default("user")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
