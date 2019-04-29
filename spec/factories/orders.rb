# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                 :bigint(8)        not null, primary key
#  status             :integer          default("initiated")
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

FactoryBot.define do
  factory :order do
    stripe_customer_id { "MyString" }
    id { 1 }
    user { FactoryBot.create(:user) }
  end
end
