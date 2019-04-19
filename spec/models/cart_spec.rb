# frozen_string_literal: true

# == Schema Information
#
# Table name: carts
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)
#
# Indexes
#
#  index_carts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { FactoryBot.build(:cart) }

  describe 'when Model is instantiated' do
    subject(:new_cart) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
    end
  end

  context "when Model is associated" do
    describe "#user" do
      it { expect(cart).to belong_to(:user) }
    end
  end
end
