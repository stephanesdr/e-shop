# frozen_string_literal: true

module Home
  class SearchController < HomeController
    def index
      @categories = Category.all
      item_name = params[:search].capitalize
      if Item.where("name like ?", "%#{item_name}%").exists? && Item.where("name like ?", "%#{item_name}%").count > 1
        @items = Item.where("name like ?", "%#{item_name}%").page(params[:page])
      elsif Item.where("name like ?", "%#{item_name}%").exists? && Item.where("name like ?", "%#{item_name}%").count == 1
        item = Item.find_by("name like ?", "%#{item_name}%")
        redirect_to home_item_path(item.id)
      else
        flash[:alert] = "Nous n'avons pas pu acceder à votre requête."
        redirect_to root_path
      end
      return unless current_user

      @products = []
      @cart = Cart.find(current_user.cart.id)
      CartItem.where(cart_id: @cart.id).each { |cart_item| @products << cart_item.item }
    end
  end
end
