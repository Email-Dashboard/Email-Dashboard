class CreateReceivers < ActiveRecord::Migration[5.1]
  def change
    create_table :receivers do |t|
      t.references :activity, foreign_key: true
      t.string :email, index: true
      t.string :phone, index: true

      t.timestamps
    end
  end
end
