# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  account_id :integer
#  slug       :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :account

  has_many :notification_delivers
  accepts_nested_attributes_for :notification_delivers, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
end
