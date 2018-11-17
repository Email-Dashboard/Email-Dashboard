class AddGitUrlToNotificationContent < ActiveRecord::Migration[5.1]
  def change
    add_column :notification_contents, :git_url, :string
    add_column :notification_contents, :last_sync_at, :datetime
  end
end
