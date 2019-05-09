# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe 'Model instantiation' do
    subject(:new_user) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:admin).of_type(:boolean).with_options(default: false) }
      it { is_expected.to have_db_column(:email).of_type(:string).with_options(null: false) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
      it { is_expected.to have_db_column(:confirmation_sent_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:confirmation_token).of_type(:string) }
    end
  end

  context 'when validation is ok' do
    it { expect(build(:user)).to be_valid }
  end
end
