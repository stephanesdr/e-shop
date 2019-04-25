# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :stripe_customer_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
