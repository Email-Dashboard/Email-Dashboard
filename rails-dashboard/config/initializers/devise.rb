# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|

  config.secret_key = '92a374cd547095dae9f73b9c8de22e36101163e3f370b6591d0c1fe86b3c7c46c90eddbf611e4dd49f13cc5225b0ead80a1dbb0dd94296fc9de87a8ec9862079'

  config.mailer_sender = 'welcome@notifications.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 11

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
