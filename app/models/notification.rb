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

  validates :name, presence: true

  after_create :create_delivers

  def email_deliver
    notification_delivers.where(delivery_method: 'email').first
  end

  private

  def create_delivers
    notification_delivers.create(smtp_setting: account.smtp_settings.first,
                                 notification_content: account.notification_contents.first,
                                 delivery_method: 'email')
  end
end
