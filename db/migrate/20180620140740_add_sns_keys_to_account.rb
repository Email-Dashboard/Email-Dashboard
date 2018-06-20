class AddSnsKeysToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :sns_access_key, :string
    add_column :accounts, :sns_secret_key, :string
    add_column :accounts, :sns_region, :string
  end
end
