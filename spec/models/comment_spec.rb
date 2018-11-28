require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe Comment, type: :model do
  let!(:comment) {create :comment}
  let!(:comment2) {create :comment, parent_id: comment.id}
  context "Associtations test" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :review}
  end

  context "columns test" do
    it {is_expected.to have_db_column(:content).of_type :text}
    it {is_expected.to have_db_column(:parent_id).of_type :integer}
    it {is_expected.to have_db_column(:lft).of_type :integer}
    it {is_expected.to have_db_column(:rgt).of_type :integer}
    it {is_expected.to have_db_column(:depth).of_type :integer}
    it {is_expected.to have_db_column(:children_count).of_type :integer}
  end

  context "Validations test" do
    it {is_expected.to validate_presence_of :content}
    it {is_expected.to validate_length_of(:content).is_at_most Settings.size.text_2000}
  end

  context "Scopes test" do
    it "order_desc" do
      expect(Comment.order_desc).to eq [comment2, comment]
    end
  end
end
