require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe Review, type: :model do
  context "Associtations test" do
    it{is_expected.to have_many :comments}
    it{is_expected.to have_many :likes}
    it{is_expected.to belong_to :user}
    it{is_expected.to belong_to :tour}
  end

  context "columns test" do
    it{is_expected.to have_db_column(:title).of_type :string}
    it{is_expected.to have_db_column(:content).of_type :text}
  end

  context "Validations test" do
    it{is_expected.to validate_presence_of :title}
    it{is_expected.to validate_presence_of :content}
    it{is_expected.to validate_length_of(:title)
      .is_at_most Settings.size.length_max_255}
    it{is_expected.to validate_length_of(:content)
      .is_at_most Settings.size.text_2000}
  end
end
