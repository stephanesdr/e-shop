# frozen_string_literal: true

module Home
  class OrdersController < ApplicationController
    before_action :authenticate_user!

    def destroy
      @order = Order.find(params[:id])
      Order.delete(@order)
      flash[:notice] = "Cette commande a été retirée de votre panier"
      redirect_to request.referer
    end

    def invoice
      @order = Order.find(params[:order_id])
      @user = @order.user
      @user_profile = @order.user.profile

      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Order No. #{@order.id}",
                 page_size: 'A4',
                 template: "home/orders/invoice.html.erb", formats: :html, encoding: 'utf8',
                 layout: "pdf.html",
                 orientation: "Portrait",
                 lowquality: true,
                 zoom: 1,
                 dpi: 75
        end
      end
    end

    def show
      @order = Order.find(params[:id])
    end

    def new
      @user = current_user
      @cart = current_user.cart
      @amount = @cart.sum_price * 100
    end

    def create
      @cart = current_user.cart
      # Amount in cents
      @amount = (@cart.sum_price * 100).to_i

      customer = Stripe::Customer.create(
        email: params[:stripeEmail],
        source: params[:stripeToken],
      )

      Stripe::Charge.create(
        customer: customer.id,
        amount: @amount,
        description: 'Rails Stripe customer',
        currency: 'eur',
      )

      #-----------------------------------

      @items = @cart.items
      @order = Order.create(user_id: current_user.id, stripe_customer_id: customer.id)
      @items.each { |item| ItemOrder.create(item_id: item.id, order_id: @order.id) }
      CartItem.where(cart_id: @cart.id).each { |cart_item| CartItem.delete(cart_item) }

      flash[:notice] = "Commande effectuée avec succès"
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to request.referer
    end
  end
end
