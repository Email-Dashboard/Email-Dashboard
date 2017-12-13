json.extract! notification, :id, :name, :created_at, :updated_at
json.url notification_url(notification, format: :json)
