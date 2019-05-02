# frozen_string_literal: true

module Home
  class CartItemsController < HomeController
    def update
      @item = Item.find(params[:id])
      quantity = if params[:quantity].to_i.zero?
                   1
                 else
                   params[:quantity].to_i
                 end
      CartItem.create(cart_id: current_user.cart.id, item_id: @item.id, quantity: quantity)
      # redirect_to request.referer
      # flash[:notice] = "#{@item.name} a été ajouté au panier"
      respond_to do |format|
        format.js
        flash[:notice] = "#{@item.name} a été ajouté au panier"
        format.html { redirect_to root_path }
      end
    end

    def destroy
      @cart_item = CartItem.find(params[:id])
      CartItem.delete(@cart_item)
      flash[:notice] = "#{@cart_item.item.name} a été retiré de votre panier"
      redirect_to request.referer
    end
  end
end
