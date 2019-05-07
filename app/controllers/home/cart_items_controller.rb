# frozen_string_literal: true

module Home
  class CartItemsController < HomeController
    def create
      @item = Item.find(params[:item_id])
      quantity = if params[:quantity].to_i.zero?
                   1
                 else
                   params[:quantity].to_i
                 end
      if CartItem.where(item_id: @item.id, cart_id: current_user.cart.id).exists?
        existant_article = CartItem.where(item_id: @item.id, cart_id: current_user.cart.id).first
        new_quantity = existant_article.quantity + quantity
        existant_article.update(quantity: new_quantity)
      else
        CartItem.create(cart_id: current_user.cart.id, item_id: @item.id, quantity: quantity)
      end

      respond_to do |format|
        format.js
        flash[:notice] = "#{@item.name} a été ajouté au panier"
        format.html { redirect_to request.referer }
      end
    end

    def update
      @cart_item = CartItem.find(params[:id])
      @cart_item.update(quantity: params[:cart_item][:quantity].to_i)
      respond_to do |format|
        format.js
        format.html { redirect_to request.referer }
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
