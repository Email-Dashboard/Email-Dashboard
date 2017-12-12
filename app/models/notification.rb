# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  account_id :integer
#  slug       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ApplicationRecord
  belongs_to :account
end
