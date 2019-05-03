# frozen_string_literal: true

module Home
  class CartsController < HomeController
    def index
      @cart_items = current_user.cart.cart_items
      @cart = Cart.find(current_user.cart.id)
    end
  end
end
