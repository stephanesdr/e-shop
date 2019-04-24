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

require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { FactoryBot.build(:item, name: "Paracetamoule", price: 98.3, discount: false, percentage_discount: 22) }

  describe 'Model instantiation' do
    subject(:new_item) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
      it { is_expected.to have_db_column(:price).of_type(:float) }
      it { is_expected.to have_db_column(:percentage_discount).of_type(:integer) }
      it { is_expected.to have_db_column(:name).of_type(:string) }
      it { is_expected.to have_db_column(:discount).of_type(:boolean) }
    end
  end

  describe 'Reduced_Price' do
    context 'when the item has a discount' do
      let(:item) { build(:item, price: 100.00, percentage_discount: 10) }

      it { expect(item.reduced_price).to eq(90.00) }
    end
  end

  it "has a valid factory" do
    expect(build(:item)).to be_valid
  end

  context "when validation" do
    it "is valid with valid attributes" do
      expect(item).to be_a(Item)
    end

    describe "#name" do
      it { expect(item.name).to be_a(String) }
    end

    describe "#price" do
      it { expect(item.price).to be_a(Float) }
    end

    describe "#discount" do
      it { expect(item.discount).to be_in([true, false]) }
    end

    describe "#percentage_discount" do
      it { expect(item.percentage_discount).to be_a(Integer) }
    end
  end
end
