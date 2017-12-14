Rails.application.routes.draw do

  root 'notifications#index'

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
  resources :notification_contents
end
