Rails.application.routes.draw do
  devise_for :user, controllers: { registrations: 'registrations', sessions: 'sessions' }

  devise_scope :user do
    authenticated :user do
      root to: 'activities#index', as: :authenticated_root
    end
  end

  root 'activities#index'

  namespace :api do
    namespace :v1 do
      resources :notifications, except: [:new, :create, :edit, :update, :destroy] do
        member do
          post :notify_email
        end
      end
    end

    namespace :v2 do
      resources :notifications, only: [] do
        resources :notifiers, only: %i(create)
      end
    end
  end

  resources :notifications do
    resources :notification_delivers, only: :update
  end

  resources :smtp_settings
  resources :accounts do
    member do
      post :set_current
    end
  end

  resources :invitations, only: [:create, :update]

  resources :notification_contents do
    member do
      get :preview
    end
  end

  resources :activities, only: %i(index show)

  # Sidekiq Web UI
  require 'sidekiq/web'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USER'])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PWD']))
  end if Rails.env.production?

  mount Sidekiq::Web, at: '/sidekiq'
end
