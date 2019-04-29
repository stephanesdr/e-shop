# frozen_string_literal: true

module Administration
  class OrdersController < AdministrationController
    def index
      @orders = Order.all
    end
  end
end
