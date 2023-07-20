class ItemsController < ApplicationController
    def index
        @items = Item.all
      
        if params[:category]
          category = Category.find_by(name: params[:category])
          @items = @items.where(category: category)
        end
      
        if params[:for_sale]
          @items = @items.where("discount > ?", 0)
        end
      
        if params[:recent]
          @items = @items.where("last_update >= ?", 3.days.ago)
        end
      
        if params[:new]
          @items = @items.where("date_create >= ?", 3.days.ago)
        end
      
        @items = @items.page(params[:page]).per(10)
    end

    def show
        @item = Item.find(params[:id])
    end

    def category
        @category = Category.find_by(name: params[:category])
        @items = @category.items.page(params[:page]).per(5)
    end

      
  end