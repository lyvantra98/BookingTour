require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe CategoriesController, type: :controller do
  describe "GET #show" do
    let!(:category) {create :category}
    let!(:category2) {create :category, parent_id: category.id}
    let!(:tour1) {create :tour, category: category}
    let!(:tour2) {create :tour, category: category2}
    before {get :show, params: {id: category.id}}

    it "returns a success response" do
      expect(response).to be_success
    end

    it "renders the show template" do
      expect(response).to render_template :show
    end

    it "return array of tour include sub tour" do
      expect(assigns(:tours)).to match_array [tour1, tour2]
    end

    it "return array of category include sub category" do
      expect(assigns(:categories)).to eq [category, category2]
    end
  end
end
