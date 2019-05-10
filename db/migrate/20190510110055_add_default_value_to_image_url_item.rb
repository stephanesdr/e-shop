# frozen_string_literal: true

class AddDefaultValueToImageUrlItem < ActiveRecord::Migration[5.2]
  def change
    change_column_default :items, :image_url, from: nil, to: "default-plant.jpg"
  end
end
