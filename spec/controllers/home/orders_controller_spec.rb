# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Home::OrdersController, type: :controller do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "GET #show" do
    let(:order) { create(:order) }

    it "assigns the requested order to @order" do
      get :show, params: { id: order.id }
      expect(assigns(:order)).to eq(order)
    end

    it "displays the order show view" do
      get :show, params: { id: order.id }
      response.should render_template :show
    end

    it "show access" do
      get :show, params: { id: order.id }
      expect(response).to have_http_status(:success)
    end
  end
end
