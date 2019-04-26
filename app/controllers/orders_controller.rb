# frozen_string_literal: true

class OrdersController < ApplicationController
  def destroy
    @order = Order.find(params[:id])
    Order.delete(@order)
    flash[:notice] = "Cette commande a été retiré de votre panier"
    redirect_to request.referer
  end
end
