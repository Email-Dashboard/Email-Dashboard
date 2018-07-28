# == Schema Information
#
# Table name: activities
#
#  id                      :integer          not null, primary key
#  notification_deliver_id :integer
#  request_content         :json
#  status                  :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  error_message           :string(255)
#

class Activity < ApplicationRecord
  belongs_to :notification_deliver

  has_many :receivers

  STATUSES = %w[pending scheduled fail success canceled].freeze

  TRACK_STATUSES = {
    sent: 'Sent',
    delivery: 'Deliveried',
    bounce: 'Bounced',
    complaint: 'Complained'
  }
end
