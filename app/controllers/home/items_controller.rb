# frozen_string_literal: true

module Home
  class ItemsController < HomeController
    def show
      @item = Item.find(params[:id])

      return if current_user == true

      @products = []
      @cart = Cart.find(current_user.cart.id)
      CartItem.where(cart_id: @cart.id).each { |cart_item| @products << cart_item.item }
    end
  end

  def index
    # @category = Category.find(params["category_id"])
    # @items = @category.items
    @items = Item.all
  end
end
