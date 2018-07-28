Rails.application.routes.draw do
  devise_for :user, controllers: { registrations: 'registrations', sessions: 'sessions' }, path: 'auth'

  devise_scope :user do
    authenticated :user do
      root to: 'dashboards#index', as: :authenticated_root
    end

    unauthenticated do
      root to: 'registrations#new', as: :unauthenticated_root
    end
  end

  root 'dashboards#index'

  resources :notifications do
    resources :notification_delivers, only: :update
  end

  resources :smtp_settings, path: 'smtp'
  resources :accounts do
    member do
      post :set_current
    end
  end

  resource :trackings

  resources :invitations, only: %i[create update]

  resources :notification_contents, path: 'templates' do
    member do
      get :preview
    end
  end

  resources :activities, only: %i[index show] do
    resource :schedulers, only: %i[show update]
  end

  resources :dashboards, only: :index
end
