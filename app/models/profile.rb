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

class Profile < ApplicationRecord
  belongs_to :user
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :street, presence: true
  validates :postal_code, presence: true
  validates :city, presence: true
end
