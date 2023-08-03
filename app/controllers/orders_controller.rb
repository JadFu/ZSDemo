class OrdersController < ApplicationController
    before_action :authenticate_user!, only: [:new]
  
    def new
      @order = Order.new(user_id: current_user.id, status_id: Status.find_by(name: 'new').id, discount: 0)
      @cart_items = session[:cart] || {}
  
      @cart_items.each do |item_id, quantity|
        item = Item.find(item_id)
        order_item = OrderItem.create(order_id: @order.id, item_id: item.id, price_ATM: item.price, quantity: quantity)
        puts "Order Item #{order_item.id} created: Order ID: #{order_item.order_id}, Item ID: #{order_item.item_id}, Quantity: #{order_item.quantity}"
      end
  
      if @order.save
        session[:cart] = nil
        puts "Order created: Order ID: #{@order.id}, User ID: #{@order.user_id}"
        redirect_to order_path(@order), notice: 'Order created successfully.'
      else
        puts "Failed to create order."
        redirect_to cart_path, alert: 'Failed to create order.'
      end
    end
  
    # Other order-related actions can be added here
  end
  
  