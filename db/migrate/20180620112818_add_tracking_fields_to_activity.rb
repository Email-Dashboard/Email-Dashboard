class AddTrackingFieldsToActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :message_header_id, :string, index: true
    add_column :activities, :track_status, :string, index: true
  end
end
