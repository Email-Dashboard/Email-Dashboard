class AddMailToToActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :error_message, :string
  end
end
