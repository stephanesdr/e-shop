# frozen_string_literal: true

# == Schema Information
#
# Table name: cart_items
#
#  id         :bigint(8)        not null, primary key
#  quantity   :integer          default(1)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cart_id    :bigint(8)
#  item_id    :bigint(8)
#
# Indexes
#
#  index_cart_items_on_cart_id  (cart_id)
#  index_cart_items_on_item_id  (item_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id)
#  fk_rails_...  (item_id => items.id)
#

require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:cart_item) { FactoryBot.build(:cart_item, cart_id: 1, item_id: 1) }

  describe 'when Model is instantiated' do
    subject(:new_cart_item) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:cart_id).of_type(:integer) }
      it { is_expected.to have_db_column(:item_id).of_type(:integer) }
    end
  end

  context "when Model is associated" do
    describe "Cart" do
      it { expect(cart_item).to belong_to(:cart) }
    end

    describe "Item" do
      it { expect(cart_item).to belong_to(:item) }
    end
  end
end
