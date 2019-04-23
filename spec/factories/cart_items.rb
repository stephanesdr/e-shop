# frozen_string_literal: true

# == Schema Information
#
# Table name: cart_items
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cart_id    :bigint(8)
#  item_id    :bigint(8)
#
# Indexes
#
#  index_cart_items_on_cart_id  (cart_id)
#  index_cart_items_on_item_id  (item_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id)
#  fk_rails_...  (item_id => items.id)
#

FactoryBot.define do
  factory :cart_item do
    cart_id { 1 }
    item_id { 1 }
  end
end
