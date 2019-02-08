class AddTestApiKeyToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :test_api_key, :string
    add_index :accounts, :test_api_key
  end
end
