# == Schema Information
#
# Table name: smtp_settings
#
#  id         :integer          not null, primary key
#  account_id :integer
#  provider   :string(255)
#  address    :string(255)
#  port       :string(255)
#  username   :string(255)
#  password   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SmtpSetting < ApplicationRecord
  belongs_to :account

  has_many :notification_delivers

  # attr_encrypted :password, key: SecureRandom.random_bytes(32)
  # attr_encrypted :username, key: SecureRandom.random_bytes(32)

  validates :provider, :address, :port, :username, :password, presence: true

  before_save :update_aws_ses_address, :if => Proc.new { |smtp| smtp.address == 'email-smtp.amazonaws.com' }

  AWS_SES_REGIONS = {
    'us-east-1': 'US East (N. Virginia)',
    'us-west-2': 'US West (Oregon)',
    'eu-west-1': 'EU (Ireland)'
  }.freeze


  def update_aws_ses_address
    self.address = "email-smtp.#{aws_region}.amazonaws.com"
  end
end
