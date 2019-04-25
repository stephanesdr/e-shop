# frozen_string_literal: true

class CartItemsController < ApplicationController
  def update
    @item = Item.find(params[:id])
    CartItem.create(cart_id: current_user.cart.id, item_id: @item.id)
    flash[:notice] = "#{@item.name} a été ajouté au panier"
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    CartItem.delete(@cart_item)
    flash[:notice] = "#{@cart_item.item.name} a été retiré de votre panier"
    redirect_to request.referer
  end
end
