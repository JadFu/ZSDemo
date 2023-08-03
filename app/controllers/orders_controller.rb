class OrdersController < ApplicationController
    def show
        @order = Order.find_by(id: params[:id])
        @order_items = OrderItem.where(order_id: params[:id])
    end
end
  
  