source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'devise', '~> 4.2'
gem 'devise_invitable', '~> 1.7.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate', git: 'https://github.com/ctran/annotate_models.git'
  gem 'letter_opener'

  gem 'capistrano3-puma', github: "seuros/capistrano-puma"
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-faster-assets', '~> 1.0', require: false
  gem 'capistrano-bundler', git: 'https://github.com/capistrano/bundler.git', branch: 'master', require: false
  gem 'capistrano-passenger'
  gem 'binding_of_caller'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'friendly_id', '~> 5.1.0'
gem "attr_encrypted", "~> 3.0.0"

gem 'haml-rails', '~> 1.0'
gem 'simple_form'
gem 'bugsnag'
gem 'responders'
gem 'kaminari'

# Enable Cross-Origin
gem 'rack-cors', :require => 'rack/cors'
# Rate Limiting and Throttling
gem 'rack-attack'

gem 'aws-sdk', '~> 3'
gem 'coderay'
gem 'awesome_print'
gem "breadcrumbs_on_rails"
