# frozen_string_literal: true

# == Schema Information
#
# Table name: category_items
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint(8)
#  item_id     :bigint(8)
#
# Indexes
#
#  index_category_items_on_category_id  (category_id)
#  index_category_items_on_item_id      (item_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (item_id => items.id)
#

require 'rails_helper'

RSpec.describe CategoryItem, type: :model do
  let(:category_item) { FactoryBot.build(:category_item, category_id: 1, item_id: 3) }

  describe 'when Model is instantiated' do
    subject(:new_category_item) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:category_id).of_type(:integer) }
      it { is_expected.to have_db_column(:item_id).of_type(:integer) }
    end
  end

  context "when Model is associated" do
    describe "category" do
      it { expect(category_item).to belong_to(:category) }
    end

    describe "Item" do
      it { expect(category_item).to belong_to(:item) }
    end
  end
end
