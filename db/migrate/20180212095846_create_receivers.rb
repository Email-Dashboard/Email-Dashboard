class CreateReceivers < ActiveRecord::Migration[5.1]
  def change
    create_table :receivers do |t|
      t.references :activity, foreign_key: true
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
