Rails.application.routes.draw do
  devise_for :users
  # Devise for admin_users should be defined only once
  devise_for :admin_users, ActiveAdmin::Devise.config
  namespace :admin do
    # Add the new OrderItem resource inside the namespace block
    resources :users
    resources :statuses
    resources :categories
    resources :taxes
    resources :items
    resources :orders
    resources :order_items
  end
  ActiveAdmin.routes(self)

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  resources :items
  get 'items/category/:id', to: 'items#category', as: :items_category
  get '/add_to_cart/:id', to: 'cart#add_to_cart', as: 'add_to_cart'
end

