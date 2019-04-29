# frozen_string_literal: true

class AddColumnToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :status, :integer, default: 0
  end
end
