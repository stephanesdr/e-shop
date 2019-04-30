# frozen_string_literal: true

module Administration
  class OrdersController < AdministrationController
    def index
      @orders = Order.all
    end

    def show
      @order = Order.find(params[:id])
    end

    def update
      puts params
      @order = Order.find(params[:id])
      @order.update(status: params[:order][:status].to_i)
      redirect_to administration_orders_path
    end
  end
end
