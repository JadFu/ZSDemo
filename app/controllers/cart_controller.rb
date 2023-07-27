class CartController < ApplicationController
    def add_to_cart
        item = Item.find(params[:id])
        session[:cart] ||= {}
        session[:cart][item.id] ||= 0
        session[:cart][item.id] += 1
        redirect_to root_path, notice: "#{item.name} added to cart."
    end
end
