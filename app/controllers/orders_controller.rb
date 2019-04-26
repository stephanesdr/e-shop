# frozen_string_literal: true

class OrdersController < ApplicationController
  def create
    @cart = current_user.cart
    @items = @cart.items
    @order = Order.create(user_id: current_user.id, stripe_customer_id: "stripe_test_current_user")
    @items.each { |item| ItemOrder.create(item_id: item.id, order_id: @order.id) }
    CartItem.where(cart_id: @cart.id).each { |cart_item| CartItem.delete(cart_item) }
    redirect_to request.referer
    flash[:notice] = "Commande effectuée avec succès"
  end
end
