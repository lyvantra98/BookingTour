require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user){ FactoryBot.create :user}
  context "Associtations test" do
    it{is_expected.to have_many :bookings}
    it{is_expected.to have_many :reviews}
    it{is_expected.to have_many :comments}
    it{is_expected.to have_many :likes}
  end

  context "columns test" do
    it{is_expected.to have_db_column(:name).of_type :string}
    it{is_expected.to have_db_column(:email).of_type :string}
    it{is_expected.to have_db_column(:is_admin).of_type :boolean}
    it{is_expected.to have_db_column(:address).of_type :string}
    it{is_expected.to have_db_column(:phone).of_type :string}
  end
  context "Validations test" do
    it{is_expected.to validate_presence_of :name}
    it{is_expected.to validate_length_of(:name).is_at_most Settings.size.length_max_name}
    it{is_expected.to validate_presence_of :email}
    it{is_expected.to validate_length_of(:email).is_at_most Settings.size.length_max_255}
    it{is_expected.to validate_presence_of :password}
    it{is_expected.to validate_length_of(:password).is_at_least Settings.size.min_password}
    it{is_expected.to validate_presence_of :phone}
    it{is_expected.to validate_presence_of :address}
    it{is_expected.to validate_length_of(:address).is_at_most Settings.size.length_max_255}
  end

  context "Scopes test" do
    it "Select user" do
      expect(User.show_user).to eq [user]
    end

    it "scope show user sort desc" do
      expect(User.show_user_desc).to eq [user]
    end
  end
end
