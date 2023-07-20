class ItemsController < ApplicationController
    def index
      @items = Item.all.page(params[:page]).per(10) 
    end
    def show
        @item = Item.find(params[:id])
    end
  end