# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id               :bigint(8)        not null, primary key
#  delivery_address :string           not null
#  first_name       :string           not null
#  last_name        :string           not null
#  phone_number     :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint(8)
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'Model instantiation' do
    subject(:new_profile) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:first_name).of_type(:string).with_options(presence: true) }
      it { is_expected.to have_db_column(:last_name).of_type(:string).with_options(presence: true) }
      it { is_expected.to have_db_column(:phone_number).of_type(:string).with_options(presence: true) }
      it { is_expected.to have_db_column(:delivery_address).of_type(:string).with_options(presence: true) }
      it { is_expected.to belong_to :user }
    end
  end

  describe 'Valid with valid attributes' do
    context 'when the category has valid attribute' do
      it { expect(build(:profile)).to be_valid }
      it { is_expected.to be_a(Profile) }
    end
  end
end
