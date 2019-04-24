# frozen_string_literal: true

class ItemsController < ApplicationController
  # before_action :authenticate_admin! only: [:destroy]

  def index
    @items = Item.all
  end

  def destroy
    @item = Item.find(params[:id])
    CartItem.where(item_id: @item.id).each { |cart_item| CartItem.delete(cart_item) }
    CategoryItem.where(item_id: @item.id).each { |category_item| CategoryItem.delete(category_item) }
    # OrderItem.where(item_id: @item.id).each {|order_item| OrderItem.delete(order_item) }
    Item.delete(@item)
    redirect_to request.referer
  end
end
