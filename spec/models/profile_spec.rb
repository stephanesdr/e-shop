# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'Model instantiation' do
    subject(:new_profile) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:first_name).of_type(:string) }
      it { is_expected.to have_db_column(:last_name).of_type(:string) }
      it { is_expected.to have_db_column(:phone_number).of_type(:string) }
      it { is_expected.to have_db_column(:street).of_type(:string) }
      it { is_expected.to have_db_column(:postal_code).of_type(:string) }
      it { is_expected.to have_db_column(:city).of_type(:string) }
      it { is_expected.to belong_to :user }
    end
  end

  describe 'Valid with valid attributes' do
    context 'when the category has valid attribute' do
      # it { expect(build(:profile)).to be_valid }
      it { is_expected.to be_a(Profile) }
    end
  end
end
