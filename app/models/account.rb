# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  slug       :string(255)
#  api_key    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Account < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :notifications

  before_create :generate_token

  protected

  def generate_token
    self.api_key = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Account.exists?(api_key: random_token)
    end
  end
end
