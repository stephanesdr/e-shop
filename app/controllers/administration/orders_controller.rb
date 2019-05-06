# frozen_string_literal: true

module Administration
  class OrdersController < AdministrationController
    def index
      @orders = Order.all
    end

    def items_checklist
      @order = Order.find(params[:order_id])
      @user = @order.user
      @items = @order.items
      @user_profile = @order.user.profile

      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Checklist_Order No. #{@order.id}",
                 page_size: 'A4',
                 template: "administration/orders/order_items_checklist.html.erb", formats: :html, encoding: 'utf8',
                 layout: "pdf.html",
                 orientation: "Portrait",
                 lowquality: true,
                 zoom: 1,
                 dpi: 75
        end
      end
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

    def sending_room
      @orders = Order.where(status: "initiated")
    end

    def update
      puts params
      @order = Order.find(params[:id])
      if @order.update(status: params[:order][:status].to_i)
        flash[:notice] = "Order status updated successfully"
      else
        flash[:danger] = "Order status update abort"
      end
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
