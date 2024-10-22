Rails.application.routes.draw do
  get "shop/index"
  get "book/new"
  devise_for :users
  root to: "home#index"
  get "admin", to: "admin#index"

  # Book
  get "admin/book/new", to: "book#new"
  post "admin/book/new", to: "book#create"
  get "admin/book/edit/:id", as: "admin_book_edit", to: "book#edit"
  put "admin/book/edit/:id", as: "admin_book_update", to: "book#update"
  delete "admin/:id", as: "delete_book", to: "book#destroy"
  get "book/index", as: "book_list", to: "book#index"
  get "book/details/:id", as: "book_details", to: "book#details"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
