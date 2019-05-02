# frozen_string_literal: true

module Home
  class LandingController < HomeController
    def index
      @categories = Category.all
      @items = Item.all

      return if current_user == true

      @products = []
      @cart = Cart.find(current_user.cart.id)
      CartItem.where(cart_id: @cart.id).each { |cart_item| @products << cart_item.item }
    end
  end
end
