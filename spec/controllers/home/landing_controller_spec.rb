# frozen_string_literal: true

RSpec.describe Home::LandingController, type: :controller do
  login_user
  describe 'get #index' do
    let(:category) { create(:category) }

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

      it "assigns all categories as @categories" do
        get :index # , params: {}
        expect(assigns(:categories)).to eq([category])
      end
    end
  end
end
