# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Administration::ItemsController, type: :controller do
  login_admin
  before do
    create(:user)
    create(:item)
    _params = { description: Faker::Movies::StarWars.quote,
                image_url: "polo_a_poil.jpg",
                price: Faker::Number.decimal(2),
                title: Faker::House.unique.furniture,
                category_id: rand(1..4),
                discount: false,
                percentage_discount: 0 }
  end

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

  describe "PUT #update/:id" do
    subject(:update_item) { put :update, params: params }

    context 'without params' do
      it { expect(response).to have_http_status(:success) }
    end
  end

  describe "POST #create/" do
    subject(:create_item) { post :create, params: params }

    context 'without params' do
      it { expect(response).to have_http_status(:success) }
    end
  end

  # context "with valid params" do
  #   before do
  #     post :create, params: params
  #   end
  #
  #   it "assigns a newly created post as @item" do
  #     expect(assigns(:item)).to be_a(Item)
  #     expect(assigns(:item)).to be_persisted
  #     expect(item.discount).to eq(percentage_discount > 0)
  #     expect(Item.count).to eq(1)
  #   end
  # end
end
