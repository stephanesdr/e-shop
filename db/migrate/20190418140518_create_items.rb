# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.float :price
      t.boolean :discount, default: false
      t.integer :percentage_discount, default: 0

      t.timestamps
    end
  end
end
