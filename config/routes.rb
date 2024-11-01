Rails.application.routes.draw do
  get "category/index"
  get "shop/index"
  get "book/new"
  devise_for :users
  root to: "home#index"

  # Cart
  get "cart", as: "cart", to: "cart#index"
  post "cart/:book_id", as: "add_to_cart", to: "cart#add_item"
  patch "cart/:id", as: "update_cart_item", to: "cart#update_item"
  delete "cart/:id", as: "delete_book_from_cart", to: "cart#remove_item"

  # User
  patch "admin/user/:id", as: "make_admin", to: "user#make_admin"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :books, only: [ :index, :show ]
  resources :orders, only: [ :index, :show, :create ]
  resources :categories, only: [ :new, :create, :destroy ]
  resources :dashboard, only: [ :index ]
  scope :dashboard do
    resources :books, except: [ :index, :show ]
  end


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
