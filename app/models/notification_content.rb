# == Schema Information
#
# Table name: notification_contents
#
#  id         :integer          not null, primary key
#  account_id :integer
#  name       :string(255)
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class NotificationContent < ApplicationRecord
  belongs_to :account

  has_many :notification_delivers
end
