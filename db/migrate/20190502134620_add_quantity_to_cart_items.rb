# frozen_string_literal: true

class AddQuantityToCartItems < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_items, :quantity, :integer, default: 1
  end
end
