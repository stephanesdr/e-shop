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

class Order < ApplicationRecord
  belongs_to :user
  has_many :item_orders, dependent: :destroy
  has_many :items, through: :item_orders
  enum status: %i[initiated shipped delivered]
  after_create :order_confirmation

  def order_confirmation
    UserMailer.order_email(self).deliver_now
  end

  def created_at_french
    year = format('%02d', created_at.year)
    month = format('%02d', created_at.month)
    day = format('%02d', created_at.day)
    time = created_at.strftime("%Hh%M")
    "#{day}/#{month}/#{year.to_s[2..3]} - #{time}"
  end
end
