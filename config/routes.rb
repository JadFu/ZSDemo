Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :items
  get 'items/category/:id', to: 'items#category', as: :items_category
  get '/cart', to: 'carts#show', as: 'cart'
  get 'checkout', to: 'carts#checkout'
  post '/add_to_cart/:id', to: 'carts#add_to_cart', as: :add_to_cart
end
