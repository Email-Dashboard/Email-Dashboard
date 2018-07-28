if Rails.env.production?
  Bugsnag.configure do |config|
    config.api_key = ENV['BUGSNAG_API_KEY']
    config.release_stage = 'notification-center-prod'
  end
end
