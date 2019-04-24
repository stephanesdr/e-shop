# frozen_string_literal: true

class CartItemsController < ApplicationController
  def destroy
    @cart_item = CartItem.find(params[:id])
    CartItem.delete(@cart_item)
    redirect_to request.referer
  end
end
