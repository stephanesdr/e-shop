# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Model instantiation' do
    subject(:new_category) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:name).of_type(:string).with_options(presence: true) }
      it { is_expected.to have_many :category_items }
      it { is_expected.to have_many :items }
    end
  end

  describe 'Valid with valid attributes' do
    context 'when the category has valid attribute' do
      it { expect(build(:category)).to be_valid }
    end
  end
end
