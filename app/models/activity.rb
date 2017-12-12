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
#

class Activity < ApplicationRecord
  belongs_to :notification_deliver
end
