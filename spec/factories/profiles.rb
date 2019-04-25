# frozen_string_literal: true
# == Schema Information
#
# Table name: profiles
#
#  id           :bigint(8)        not null, primary key
#  city         :string
#  first_name   :string
#  last_name    :string
#  phone_number :string
#  postal_code  :string
#  street       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint(8)
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :profile do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.phone_number }
    street { Faker::Address.street_address }
    postal_code { Faker::Address.zip_code }
    city { Faker::Address.city }
    user { FactoryBot.create(:user) }
  end
end
