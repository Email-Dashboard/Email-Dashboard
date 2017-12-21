Rails.application.config.session_store :cookie_store, key: "_notification_#{Rails.env}", domain: :all, tld_length: 2
