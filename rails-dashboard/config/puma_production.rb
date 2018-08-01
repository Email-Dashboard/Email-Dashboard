environment 'production'

daemonize false

threads 1, 16

bind 'tcp://0.0.0.0:8080'

preload_app!

on_worker_boot do
  ActiveRecord::Base.establish_connection
end