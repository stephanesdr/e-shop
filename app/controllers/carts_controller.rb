# frozen_string_literal: true

class CartsController < ApplicationController
  def index
    @items = []
    CartItem.where(cart_id: current_user.id).each { |cart_item| @items << cart_item.item }
  end
end
