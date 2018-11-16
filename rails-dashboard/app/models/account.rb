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
  has_many :smtp_settings, dependent: :destroy
  has_many :notification_contents, dependent: :destroy

  has_many :account_users, dependent: :destroy
  has_many :users, through: :account_users

  before_create :generate_token

  after_create  :create_default_email_template

  scope :persisted, -> { where.not(id: nil) }

  protected

  def generate_token
    self.api_key = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Account.exists?(api_key: random_token)
    end
  end

  private

  def create_default_email_template
    content = notification_contents.create(subject: 'HTML Test Content')
    content.sync_from_git('https://raw.githubusercontent.com/Email-Dashboard/email-templates/master/simple-transactional-email.html')
  end
end
