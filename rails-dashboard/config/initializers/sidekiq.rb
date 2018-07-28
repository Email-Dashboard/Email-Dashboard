# Sidekiq client config
Sidekiq.configure_client do |config|
  config.redis = {
                    host: (ENV['REDIS_HOST_URL'] || '127.0.0.1'),
                    port: 6379,
                    db: 0,
                    namespace: 'notification_center_sidekiq',
                    password: ENV['REDIS_PASSWORD']
                  }
end

# Sidekiq server config
Sidekiq.configure_server do |config|
  config.redis = {
                    host: (ENV['REDIS_HOST_URL'] || '127.0.0.1'),
                    port: 6379,
                    db: 0,
                    namespace: 'notification_center_sidekiq',
                    password: ENV['REDIS_PASSWORD']
                  }
end

Sidekiq.default_worker_options = { retry: 0 }
