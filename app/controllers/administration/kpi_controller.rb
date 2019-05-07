# frozen_string_literal: true

module Administration
  class KpiController < AdministrationController
    def index
      @data_product_hash = {}
      Item.all.each do |item|
        @data_product_hash[item.name] = (item.item_orders.count.to_f / ItemOrder.all.count.to_f) * 100 if item.item_orders.count != 0
      end

      @data_gain_hash = Order.group_by_day(:created_at).count
      @data_gain_hash.each_key do |key|
        @data_gain_hash[key] = 0
        Order.where(created_at: key.midnight..key.end_of_day).each do |order|
          @data_gain_hash[key] += order.items.sum("price").round(2)
        end
      end
      # @data_gain_hash.each_key { |key| key = key.strftime("%a %d %b") }
    end
  end
end
