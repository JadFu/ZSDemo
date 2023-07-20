class ItemsController < ApplicationController
    def index
        @items = Item.all
      
        if params[:keyword].present?
            keyword = params[:keyword].downcase
            @items = @items.where("LOWER(name) LIKE ?", "%#{keyword}%")
        end

        if params[:category]
          category = Category.find_by(name: params[:category])
          @items = @items.where(category: category)
        end
      
        if params[:search_factor] == 'new'
            @items = @items.where('date_create >= ?', 3.days.ago)
        elsif params[:search_factor] == 'recent'
            @items = @items.where('last_update >= ?', 3.days.ago)
        elsif params[:search_factor] == 'for_sale'
            @items = @items.where('discount > ?', 0)
        else
            @items = @items
        end
      
        @items = @items.page(params[:page]).per(10)
    end

    def category
        @category = Category.find_by(name: params[:category])
        @items = @category.items.page(params[:page]).per(5)
    end

    def show
        if params[:id] == "search"
          # Handle search functionality
          search_items
        else
          # Show individual item
          @item = Item.find(params[:id])
        end
    end
      
    private

    def search_items
        search_params = {
          keyword: params[:keyword],
          category_id: params[:category_id],
          for_sale: params[:for_sale],
          search_factor: params[:search_factor]
        }
      
        redirect_to items_path(search_params.compact)
    end
      

      
  end