# == Schema Information
#
# Table name: notification_delivers
#
#  id                      :integer          not null, primary key
#  notification_id         :integer
#  smtp_settings_id        :integer
#  notification_content_id :integer
#  delivery_method         :string(255)
#  is_active               :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class NotificationDeliver < ApplicationRecord
  belongs_to :notification
  belongs_to :smtp_setting
  belongs_to :notification_content

  has_many :activities
end
