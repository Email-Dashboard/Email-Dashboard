class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.references :notification_deliver, foreign_key: true
      t.json :request_content
      t.string :status

      t.timestamps
    end
  end
end
