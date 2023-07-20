class ItemsController < ApplicationController
    def index
        @items = Item.all

        if params[:category_id]
          category = Category.find_by(id: params[:category_id])
          @items = @items.where(category: category)
        end

        if params[:keyword].present?
            keyword = params[:keyword].downcase
            @items = @items.where("LOWER(name) LIKE ?", "%#{keyword}%")
        end
      
        if params[:search_factor] == 'all'
            # No specific filter applied, show all items
        elsif params[:search_factor] == 'new'
            @items = @items.where('date_create >= ?', 3.days.ago)
        elsif params[:search_factor] == 'recent'
            @items = @items.where('last_update >= ?', 3.days.ago)
        elsif params[:search_factor] == 'for_sale'
            @items = @items.where('discount > ?', 0)
        end
      
        @items = @items.page(params[:page]).per(10)
    end

    def category
        @category = Category.find(params[:id])
        @items = Item.where(category: @category).page(params[:page]).per(10)
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
        keyword = params[:keyword].presence
        category_id = params[:category_id].presence
        category_id = nil if category_id == 'all'
      
        search_factor = params[:search_factor].presence
        search_factor = nil if search_factor == 'all'
      
        search_params = {
          keyword: keyword,
          category_id: category_id,
          search_factor: search_factor
        }.compact
      
        redirect_to items_path(search_params)
    end
      

      
  end