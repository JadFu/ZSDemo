class CartsController < ApplicationController
    def show
      @cart_items = session[:cart] || {}
    end
  
    def add_to_cart
      id = params[:id]
      session[:cart] ||= {}
      session[:cart][id] ||= 0
      session[:cart][id] += 1
      redirect_to items_path, notice: 'Item added to cart successfully.'
    end
end
  