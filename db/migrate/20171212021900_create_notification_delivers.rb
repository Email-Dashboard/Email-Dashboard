class CreateNotificationDelivers < ActiveRecord::Migration[5.1]
  def change
    create_table :notification_delivers do |t|
      t.references :notification, foreign_key: true
      t.references :smtp_settings, foreign_key: true
      t.references :notification_content, foreign_key: true
      t.string :delivery_method
      t.boolean :is_active

      t.timestamps
    end
  end
end
