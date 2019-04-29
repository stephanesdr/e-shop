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

require 'rails_helper'

RSpec.describe Order, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    @user = build(:user)
    @order = build(:order)
  end

  describe 'Database' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:stripe_customer_id).of_type(:string) }
    it { is_expected.to belong_to :user }
    it { is_expected.to have_db_column(:status).of_type(:integer) }
  end
end
