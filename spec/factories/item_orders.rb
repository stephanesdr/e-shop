# frozen_string_literal: true

# == Schema Information
#
# Table name: item_orders
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint(8)
#  order_id   :bigint(8)
#
# Indexes
#
#  index_item_orders_on_item_id   (item_id)
#  index_item_orders_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (order_id => orders.id)
#

FactoryBot.define do
  factory :item_order do
    order { FactoryBot.create(:order) }
    item { FactoryBot.create(:item) }
  end
end
