# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                 :bigint(8)        not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  stripe_customer_id :string
#  user_id            :bigint(8)
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Order < ApplicationRecord
  belongs_to :user
end
