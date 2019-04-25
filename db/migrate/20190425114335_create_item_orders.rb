# frozen_string_literal: true

class CreateItemOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :item_orders do |t|
      t.references :item, foreign_key: true
      t.references :order, foreign_key: true
      t.timestamps
    end
  end
end
