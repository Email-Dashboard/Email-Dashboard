class AddLiveRequestModeToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :request_mode_is_live, :boolean, default: true
  end
end
