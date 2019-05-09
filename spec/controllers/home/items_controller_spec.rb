# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Home::ItemsController, type: :controller do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "GET #index" do
    let(:item) { create(:item) }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "assigns all items as items" do
      get :index # , params: {}
      expect(assigns(:items)).to eq([item])
    end
  end

  describe "GET #show" do
    let(:item) { create(:item) }

    it "assigns the requested item to @item" do
      get :show, params: { id: item.id }
      expect(assigns(:item)).to eq(item)
    end

    it "displays the item show view" do
      get :show, params: { id: item.id }
      response.should render_template :show
    end

    it "show access" do
      get :show, params: { id: item.id }
      expect(response).to have_http_status(:success)
    end
  end
end
