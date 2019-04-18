# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoryItemController, type: :controller do
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
