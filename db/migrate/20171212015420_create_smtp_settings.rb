class CreateSmtpSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :smtp_settings do |t|
      t.references :account, foreign_key: true
      t.string :provider
      t.string :address
      t.string :port
      t.string :domain
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
