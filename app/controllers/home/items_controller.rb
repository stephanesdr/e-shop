# frozen_string_literal: true

module Home
  class ItemsController < HomeController
    def show
      @item = Item.find(params[:id])
    end

    def index
      # @category = Category.find(params["category_id"])
      # @items = @category.items
      @items = Item.all
    end
  end
end
