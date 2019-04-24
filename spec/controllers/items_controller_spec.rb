# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'get #index' do
    context 'with valid response from server' do
      before do
        request.env['HTTP_REFERER'] = '/'
        get :index
      end

      it "returns success" do
        expect(response).to be_successful
      end

      it 'returns 200' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
