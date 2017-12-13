Rails.application.routes.draw do

  root 'notifications#index'

  resources :notifications do
    resources :notification_delivers, only: :update
  end

  resources :smtp_settings
  resources :notification_contents
end
