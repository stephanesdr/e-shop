# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Home::CartsController, type: :controller do
  describe "GET #index" do
    login_user

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end
end
