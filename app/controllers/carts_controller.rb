require 'stripe'

class CartsController < ApplicationController
   skip_before_action :verify_authenticity_token, only: :update_cart

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
      session[:user_tax_id] = params[:user][:tax_id] # Storing the tax_id in the session
      @tax = Tax.find(session[:user_tax_id]) # Fetching the tax using the tax_id from the session
      @cart_items = session[:cart] || {}
      @total_price_before_tax = calculate_total_price_before_tax(@cart_items)
      @total_gst = @total_price_before_tax * @tax.GST
      @total_pst = @total_price_before_tax * @tax.PST
      @total_hst = @total_price_before_tax * @tax.HST
      @total_price_after_tax = calculate_total_price_after_tax
    end

    def update_cart
      item_id = params[:item_id]
      quantity = params[:quantity].to_i
    
      if session[:cart] && session[:cart][item_id] && quantity.positive?
        session[:cart][item_id] = quantity
        flash[:notice] = 'Item quantity updated successfully.'
      else
        flash[:alert] = 'Unable to update item quantity.'
      end
    
      redirect_to cart_path
    end

    def initiate_payment_link
      @tax = Tax.find(session[:user_tax_id])
      @cart_items = session[:cart] || {}
      @total_price_before_tax = calculate_total_price_before_tax(@cart_items)
      @total_gst = @total_price_before_tax * @tax.GST
      @total_pst = @total_price_before_tax * @tax.PST
      @total_hst = @total_price_before_tax * @tax.HST
      @total_price_after_tax = calculate_total_price_after_tax
    
      begin
        amount = (@total_price_after_tax * 100).to_i # Convert to cents
    
        payment_intent = Stripe::PaymentIntent.create({
          amount: amount,
          currency: 'cad',
          # Add other relevant details here, such as customer, payment method, etc.
        })
    
        # You can pass the Payment Intent's client secret to the front end to confirm the payment
        @client_secret = payment_intent.client_secret
        session[:payment_intent_id] = payment_intent.id
    
        # Redirect or render as needed
        render 'payment_confirmation'
      rescue Stripe::StripeError => e
        flash[:alert] = "Error creating Payment Intent: #{e.message}"
        redirect_to cart_path
      end
    end

    def success
      @cart_items = session[:cart] || {}
      payment_intent_id = session[:payment_intent_id]
      if session[:user_id]
        timemark = Time.current
        @user = User.find(session[:user_id])
        @order = Order.new(user_id: @user.id, status_id: Status.find_by(name: 'paid').id, stripe_payment_intent_id: payment_intent_id, discount: 0, date_create: timemark)
        if @order.save
          @createdOrder = Order.find_by(date_create: timemark)
          @cart_items.each do |item_id, quantity|
            item = Item.find(item_id)
            order_item = OrderItem.create(order_id: @createdOrder.id, item_id: item.id, price_ATM: item.price, quantity: quantity)
          end
          # Clear the cart
          session[:cart] = nil
        else
          redirect_to cart_path, alert: 'Failed to create order.'
        end
      end
    
      render 'carts/success'
    end
    

    def remove_item
      item_id = params[:item_id]
      if session[:cart] && session[:cart][item_id]
        session[:cart].delete(item_id)
        flash[:notice] = 'Item removed from cart successfully.'
      else
        flash[:alert] = 'Item not found in cart.'
      end
      redirect_to cart_path
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
  