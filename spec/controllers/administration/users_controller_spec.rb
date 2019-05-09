# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Administration::UsersController, type: :controller do
  describe "GET #index" do
    let(:user) { create(:user) }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "assigns all users as users" do
      get :index
      expect(assigns(:users)).to eq([user])
    end
  end
end
