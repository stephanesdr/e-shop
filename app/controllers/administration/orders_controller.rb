# frozen_string_literal: true

module Administration
  class OrdersController < AdministrationController
    def index
      @orders = Order.all
    end

    def postal_sticker
      @order = Order.find(params[:order_id])
      @user_profile = @order.user.profile

      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Order No. #{@order.id}",
                 page_size: 'A6',
                 template: "administration/orders/postal_sticker.html.erb",
                 layout: "pdf.html",
                 orientation: "Landscape",
                 lowquality: true,
                 zoom: 1,
                 dpi: 75
        end
      end
    end

    def show
      @order = Order.find(params[:id])
      @user_profile = @order.user.profile
    end

    def update
      puts params
      @order = Order.find(params[:id])
      @order.update(status: params[:order][:status].to_i)
      redirect_to administration_orders_path
      puts @order.status
      if @order.status == "shipped"
        UserMailer.shipped_email(@order).deliver_now
      elsif @order.status == "delivered"
        UserMailer.delivered_email(@order).deliver_now
      end
    end
  end
end
