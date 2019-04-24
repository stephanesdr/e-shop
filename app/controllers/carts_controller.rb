# frozen_string_literal: true

class CartsController < ApplicationController
  def index
    @items = []
    @cart = Cart.find(current_user.id)
    CartItem.where(cart_id: @cart.id).each { |cart_item| @items << cart_item.item }
  end
end
