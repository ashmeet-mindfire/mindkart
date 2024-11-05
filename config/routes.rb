Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  # User
  patch "admin/user/:id", as: "make_admin", to: "users#make_admin"

  resources :orders, only: [ :index, :show, :create ]
  resources :categories, only: [ :new, :create, :destroy ]
  resources :dashboard, only: [ :index ]
  # scope :dashboard do
  #   resources :books, except: [ :index, :show ]
  # end
  resources :books
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
