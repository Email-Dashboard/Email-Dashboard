class CreateNotificationContents < ActiveRecord::Migration[5.1]
  def change
    create_table :notification_contents do |t|
      t.references :account, foreign_key: true
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
