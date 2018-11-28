require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe BookingsController, type: :controller do
  let!(:user) {create :user}
  let!(:tour) {create :tour}
  let!(:valid_attributes) {attributes_for(:booking, user_id: user.id)}
  let!(:invalid_attributes){attributes_for(:booking, user_id: user.id, number_people: nil)}
  let(:update_attribute_valid) {attributes_for(:booking, number_people: 12)}
  let(:update_attribute_invalid) {attributes_for(:booking, number_people: nil)}

  before {sign_in user}

  describe "POST CREATE" do
    it "create new booking" do
      expect {
        post :create, params: {
          tour_id: tour.id,
          booking: valid_attributes}
      }.to change(Booking, :count)
    end

    it "create new booking false" do
      expect {
        post :create, params: {
          tour_id: tour.id,
          booking: invalid_attributes
        }
      }.not_to change(Booking, :count)
    end
  end

  describe "GET EDIT" do
    let!(:booking) {create :booking, valid_attributes}
    before {get :edit, params: {tour_id: tour.id, id: booking.id}}

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns @booking" do
      expect(assigns :booking).to eq booking
    end
  end

  describe "PUT #update" do
    let!(:booking) {create :booking, valid_attributes}
    context "when input valid value" do
      before do
        put :update, params: {
          tour_id: tour.id,
          id: booking.id,
          booking: update_attribute_valid}
        booking.reload
      end

      it "changes @booking attributes" do
        expect(assigns :booking).to eq booking
      end

      it "returns booking path" do
        expect(response).to redirect_to bookings_path
      end

      it "returns success flash" do
        expect(flash[:success]).to eq "Update success!"
      end
    end

    context "when input invalid value" do
      before do
        put :update, params: {
          tour_id: tour.id,
          id: booking.id,
          booking: update_attribute_invalid}
        booking.reload
      end

      it "don't changes @booking attributes" do
        expect(assigns :number_people).not_to eq booking.number_people
      end

      it "returns danger flash" do
        expect(flash[:danger]).to eq "Update fails"
      end

      it "returns edit page" do
        expect(response).to render_template :edit
      end
    end
  end
end
