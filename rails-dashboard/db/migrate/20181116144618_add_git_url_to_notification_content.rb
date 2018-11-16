class AddGitUrlToNotificationContent < ActiveRecord::Migration[5.1]
  def change
    add_column :notification_contents, :git_url, :string
  end
end
