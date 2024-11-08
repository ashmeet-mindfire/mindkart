Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  # User
  resources :users do
    member do
      patch :change_admin_status
    end
  end

  resources :orders, only: [ :index, :show, :create ]
  resources :categories, except: [ :update ]
  resources :dashboard, only: [ :index ]
  resources :books do
    member do
      patch "restore"
    end
  end
  resources :cart_items, only: [ :index, :create, :destroy ]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
