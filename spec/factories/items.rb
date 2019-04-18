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

FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    price { "9.99" }
    discount { false }
    percentage_discount { 0 }
  end
end
