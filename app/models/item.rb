# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                  :bigint(8)        not null, primary key
#  description         :text
#  discount            :boolean          default(FALSE)
#  name                :string
#  percentage_discount :integer          default(0)
#  price               :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Item < ApplicationRecord
  has_many :category_items, dependent: :destroy
  has_many :categories, through: :category_items
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many :item_orders, dependent: :destroy
  has_many :orders, through: :item_orders
  validates :price, numericality: { only_float: true, greater_than_or_equal_to: 0 }
  validates :percentage_discount, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  has_one_attached :picture

  def reduced_price
    (price - price * percentage_discount / 100).round(2)
  end
end
