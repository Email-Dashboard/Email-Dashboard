set :application, 'notification-center'
set :repo_url, 'git@gitlab.com:notification-center/dashboard.git'
set :deploy_to, "/home/ubuntu/apps/#{fetch(:application)}"
set :migration_role, 'migrator'

set :rbenv_ruby, '2.4.2'
set :rbenv_type, :user
set :keep_releases, 5
set :copy_exclude, %w(.git/* tmp/*)
set :rails_env, 'production'
# set :linked_files, %w{config/database.yml public/sitemap.xml.gz}

set :copy_exclude, %w(.git/* tmp/*)
# set :linked_files, %w{config/mongoid.yml} # we are using mongoidgerenrate.rb to generate smart app base pool
set :linked_dirs, %w{log tmp/pids tmp/cache vendor/bundle}
set :bundle_jobs, 4 #This is only available for bundler 1.4+

set :linked_files, %w{config/database.yml config/initializers/sidekiq.rb}
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
# set :format, :pretty airbrush
set :log_level, :debug
set :pty, true


before 'deploy:assets:precompile', 'deploy:yarn_install'

namespace :deploy do
  desc 'Run rake yarn:install'
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute("cd #{release_path} && yarn install")
        execute("cd #{release_path} && NODE_ENV=production RAILS_ENV=production $HOME/.rbenv/bin/rbenv exec bundle exec rake webpacker:compile")
      end
    end
  end
end
