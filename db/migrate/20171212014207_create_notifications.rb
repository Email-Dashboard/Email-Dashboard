class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :account, foreign_key: true
      t.string :slug

      t.timestamps
    end

    add_index :notifications, :slug
  end
end
