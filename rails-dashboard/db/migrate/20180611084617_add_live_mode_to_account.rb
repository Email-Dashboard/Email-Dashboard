class AddLiveModeToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :live_mode, :boolean, default: false
    add_column :accounts, :to_email_for_test, :string
  end
end
