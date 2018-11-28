require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe Admin::ReviewsController, type: :controller do
  let!(:user) {FactoryBot.create :user, is_admin: true}
  let!(:review) {FactoryBot.create :review}

  describe "GET index" do
    before :each do
      session[:user_id] = user.id
    end

    it "assigns @reviews" do
      get :index
      expect(assigns(:reviews)).to eq([review])
    end

    it "assigns @reviews invalid search" do
      get :index, params: {q: {user_name_or_title_cont: "-123456"}, page: nil}
      expect(assigns(:reviews)).to eq([])
    end

    it "assigns @reviews invalid params page" do
      get :index, params: {q: {user_name_or_title_cont: "-123"}, page: -2}
      expect(assigns(:reviews)).to eq([])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "returns a 200 OK status" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "returns a success response" do
      get :index
      expect(response).to be_success
    end
  end
end
