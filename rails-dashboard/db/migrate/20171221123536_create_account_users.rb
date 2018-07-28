class CreateAccountUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :account_users do |t|
      t.references :account, foreign_key: true
      t.references :user, foreign_key: true
      t.string :role, default: 'user'

      t.timestamps
    end
  end
end
