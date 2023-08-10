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

  root to:'items#index'

  resources :items
  resources :taxes
  get 'items/category/:id', to: 'items#category', as: :items_category
  get '/cart', to: 'carts#show', as: 'cart'
  get 'checkout', to: 'carts#checkout'
  post '/add_to_cart/:id', to: 'carts#add_to_cart', as: :add_to_cart
  post '/confirm_checkout', to: 'carts#confirm_checkout', as: 'confirm_checkout'

  get '/initiate_payment_link', to: 'carts#initiate_payment_link', as: 'initiate_payment_link'

  # cart resource
  resource :cart, only: [:show] do
    post 'remove_item', to: 'carts#remove_item', as: 'remove_item'
    put :update_cart, on: :collection, as: :update_cart
    get :checkout, on: :member, as: :checkout # Route for checkout.html.erb
    get :confirm_checkout, on: :member, as: :confirm_checkout # Route for confirm_checkout.html.erb
  end

  # payment
  get '/carts/success', to: 'carts#success'

  # user sign_up
  get '/sign_up', to: 'users#new'
  post '/sign_up', to: 'users#create'

  # user login/out
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout

  # user page
  resources :orders, only: [:new, :show]
  get '/users/:id', to: 'users#show', as: 'user'
end

