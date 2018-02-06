# == Schema Information
#
# Table name: notification_contents
#
#  id         :integer          not null, primary key
#  account_id :integer
#  subject    :string(255)
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class NotificationContent < ApplicationRecord
  belongs_to :account

  has_many :notification_delivers

  validates :subject, :content, presence: true

  def content_variables
    variables = []
    content.scan(/\s*[\w\.]+\s*}}/) do |m|
      variables << m.match(/[\w\.]+/)[0]
    end

    variables.uniq - %w(this else each)
  end
end
