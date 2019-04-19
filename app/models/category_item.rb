# frozen_string_literal: true

# == Schema Information
#
# Table name: category_items
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint(8)
#  item_id     :bigint(8)
#
# Indexes
#
#  index_category_items_on_category_id  (category_id)
#  index_category_items_on_item_id      (item_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (item_id => items.id)
#

class CategoryItem < ApplicationRecord
  belongs_to :item
  belongs_to :category
end
