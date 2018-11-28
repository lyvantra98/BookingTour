require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe Category, type: :model do
  let!(:category) {create :category}
  let!(:category2) {create :category, parent_id: category.id}
  context "Associtations test" do
    it {is_expected.to have_many :tours}
  end

  context "columns test" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:parent_id).of_type :integer}
    it {is_expected.to have_db_column(:lft).of_type :integer}
    it {is_expected.to have_db_column(:rgt).of_type :integer}
    it {is_expected.to have_db_column(:depth).of_type :integer}
    it {is_expected.to have_db_column(:children_count).of_type :integer}
  end

  context "Validations test" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_length_of(:name).is_at_most Settings.size.text_2000}
  end

  context "Scopes test" do
    it "select_custom" do
      expect(Category.select_custom).to match_array [category, category2]
    end

    it "order_lft_asc" do
      expect(Category.order_lft_asc).to eq [category, category2]
    end

    it "select_cate_desc" do
      expect(Category.select_cate_desc).to eq [category2, category]
    end
  end
end
