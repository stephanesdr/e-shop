# frozen_string_literal: true

class AddVisitsToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :ahoy_visit_id, :bigint
  end
end
