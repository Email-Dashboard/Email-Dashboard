class AddSendAtToActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :send_at, :datetime
  end
end
