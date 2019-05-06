# frozen_string_literal: true

module Home
  class LandingController < HomeController
    def index
      # ahoy.track "Landing_page"
      @categories = Category.all
      @items = Item.page(params[:page])
      @most_popular_items = Item.most_popular(5)
      return unless current_user

      @products = []
      @cart = Cart.find(current_user.cart.id)
      CartItem.where(cart_id: @cart.id).each { |cart_item| @products << cart_item.item }
    end
  end
end
