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

require 'rails_helper'

RSpec.describe ItemOrder, type: :model do
  let(:item_order) { FactoryBot.build(:item_order, order_id: 1, item_id: 1) }

  describe 'when Model is instantiated' do
    subject(:new_item_order) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:order_id).of_type(:integer) }
      it { is_expected.to have_db_column(:item_id).of_type(:integer) }
    end
  end

  context "when Model is associated" do
    describe "order" do
      it { expect(item_order).to belong_to(:order) }
    end

    describe "Item" do
      it { expect(item_order).to belong_to(:item) }
    end
  end
end
