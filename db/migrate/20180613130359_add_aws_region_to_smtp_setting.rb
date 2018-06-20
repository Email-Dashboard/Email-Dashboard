class AddAwsRegionToSmtpSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :smtp_settings, :aws_region, :string
  end
end
