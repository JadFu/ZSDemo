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

    def checkout
      @cart_items = session[:cart] || {}
      @user = User.new
      @taxes = Tax.all
    end
  
    def confirm_checkout
      @user = User.new(user_params)
      @tax = Tax.find(params[:user][:tax_id])
      @cart_items = session[:cart] || {}
      @total_price_before_tax = calculate_total_price_before_tax(@cart_items)
      @total_gst = @total_price_before_tax * @tax.GST
      @total_pst = @total_price_before_tax * @tax.PST
      @total_hst = @total_price_before_tax * @tax.HST
      @total_price_after_tax = calculate_total_price_after_tax
    end

    def update_cart
      cart_items_params.each do |item_id, quantity|
        session[:cart][item_id] = quantity.to_i if quantity.to_i.positive?
      end
  
      redirect_to cart_path, notice: 'Cart updated successfully.'
    end

    private

    def cart_items_params
      params.require(:cart_items).permit!
    end

    def user_params
      params.require(:user).permit(:email, :address, :tax_id)
    end
  
    def calculate_total_price_before_tax(cart_items)
      total_price_before_tax = 0
  
      cart_items.each do |item_id, quantity|
        item = Item.find(item_id)
        total_price_before_tax += item.price * quantity
      end
  
      total_price_before_tax
    end
  
    def calculate_total_price_after_tax
      total_price_after_tax = @total_price_before_tax * (1 + @tax.GST + @tax.PST + @tax.HST)
      total_price_after_tax
    end
end
  