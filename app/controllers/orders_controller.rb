class OrdersController < ApplicationController
    def show
        @order = Order.find_by(id: params[:id])
        @order_items = OrderItem.where(order_id: params[:id])
        @user = User.find_by(id: @order.user_id)
        @tax = Tax.find_by(id: @user.tax_id)
        @tax_rate = total_tax
    end

    private

    def total_tax
        total_tax_rate = @tax.GST + @tax.PST + @tax.HST
        total_tax_rate
    end
end
  
  