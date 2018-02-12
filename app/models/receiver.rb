# == Schema Information
#
# Table name: receivers
#
#  id          :integer          not null, primary key
#  activity_id :integer
#  value       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Receiver < ApplicationRecord
  belongs_to :activity
end
