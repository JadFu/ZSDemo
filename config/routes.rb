Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to:'items#index'

  resources :items
  get 'items/category/:id', to: 'items#category', as: :items_category
  get '/cart', to: 'carts#show', as: 'cart'
  get 'checkout', to: 'carts#checkout'
  post '/add_to_cart/:id', to: 'carts#add_to_cart', as: :add_to_cart
  post '/confirm_checkout', to: 'carts#confirm_checkout', as: 'confirm_checkout'

  # cart resource
  resource :cart, only: [:show] do
    put :update_cart, on: :collection, as: :update_cart
  end

  # user sign_up
  get '/sign_up', to: 'users#new'
  post '/sign_up', to: 'users#create'

  # user login/out
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout

  # user page
  resources :orders, only: [:show]
  get '/users/:id', to: 'users#show', as: 'user'
end
