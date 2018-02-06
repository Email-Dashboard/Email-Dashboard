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
end
