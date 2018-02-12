# Sidekiq client config
Sidekiq.configure_client do |config|
  config.redis = if Rails.env.production?
                   {
                     host: ENV['REDIS_HOST_URL'],
                     port: 6379,
                     db: 0,
                     namespace: 'notification_center_sidekiq',
                     password: ENV['REDIS_PASSWORD']
                   }
                 else
                   {
                     host: '127.0.0.1',
                     port: 6379,
                     db: 0,
                     namespace: 'notification_center_sidekiq'
                   }
                 end
end

# Sidekiq server config
Sidekiq.configure_server do |config|
  config.redis = if Rails.env.production?
                   {
                     host: ENV['REDIS_HOST_URL'],
                     port: 6379,
                     db: 0,
                     namespace: 'notification_center_sidekiq',
                     password: ENV['REDIS_PASSWORD']
                   }
                 else
                   {
                     host: '127.0.0.1',
                     port: 6379,
                     db: 0,
                     namespace: 'notification_center_sidekiq'
                   }
                 end
end
