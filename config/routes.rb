Rails.application.routes.draw do
  get "category/index"
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
  delete "admin/book/delete/:id", as: "delete_book", to: "book#destroy"
  get "book/index", as: "book_list", to: "book#index"
  get "book/details/:id", as: "book_details", to: "book#details"

  # Cart
  get "cart", as: "cart", to: "cart#index"
  post "cart/:book_id", as: "add_to_cart", to: "cart#add_item"
  patch "cart/:id", as: "update_cart_item", to: "cart#update_item"
  delete "cart/:id", as: "delete_book_from_cart", to: "cart#remove_item"

  # Order
  post "order", as: "create_order", to: "orders#create"
  get "order", as: "order_list", to: "orders#show"
  get "order/:id", as: "order_details", to: "orders#details"
  patch "order/:id", as: "order_update", to: "orders#update"

  # Category
  get "admin/category/new", as: "admin_category_new", to: "category#new"
  post "admin/category/create", as: "admin_category_create", to: "category#create"
  delete "admin/category/delete/:id", as: "admin_category_delete", to: "category#destroy"

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
