class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :slug
      t.string :api_key

      t.timestamps
    end

    add_index :accounts, :api_key
    add_index :accounts, :slug
  end
end
