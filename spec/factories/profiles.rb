# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id           :bigint(8)        not null, primary key
#  city         :string           not null
#  first_name   :string           not null
#  last_name    :string           not null
#  phone_number :string           not null
#  postal_code  :string           not null
#  street       :string           not null
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
