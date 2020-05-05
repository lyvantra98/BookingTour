require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe CommentsController, type: :controller do
  let!(:user) {create :user}
  let!(:review) {create :review}
  let(:valid_attributes) {attributes_for(:comment, user_id: user.id)}
  let(:invalid_attributes) {attributes_for(:comment, content: nil, user_id: user.id)}
  let(:update_attribute_valid) {attributes_for(:comment, content: "new content")}
  let(:update_attribute_invalid) {attributes_for(:comment, content: nil)}

  before {sign_in user}

  describe "POST #create" do
    it "creates a new comment" do
      expect {
        post :create, params: {
          review_id: review.id,
          comment: valid_attributes}
      }.to change(Comment, :count)
    end

    it "creates a new comment fail" do
      expect {
        post :create, params: {
          review_id: review.id,
          comment: invalid_attributes}
      }.not_to change(Comment, :count)
    end
  end

  describe "GET #edit" do
    let!(:comment) {create :comment, valid_attributes}
    before {get :edit, params: {review_id: review.id, id: comment.id}}

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns @comment" do
      expect(assigns :comment).to eq comment
    end
  end

  describe "PUT #update" do
    let!(:comment) {create :comment, valid_attributes}
    context "when input valid value" do
      before do
        put :update, xhr: true, params: {
          review_id: review.id,
          id: comment.id,
          comment: update_attribute_valid}
        comment.reload
      end

      it "changes @comment attributes" do
        expect(assigns :comment).to eq comment
      end

      it "returns review page" do
        expect(response).to redirect_to review_path
      end

      it "returns success flash" do
        expect(flash[:success]).to eq "Update success!"
      end
    end

    context "when input invalid value" do
      before do
        put :update, xhr: true, params: {
          review_id: review.id,
          id: comment.id,
          comment: update_attribute_invalid}
        comment.reload
      end

      it "don't changes @comment attributes" do
        expect(assigns :content).not_to eq comment.content
      end

      it "returns danger flash" do
        expect(flash[:danger]).to eq "Update fails"
      end

      it "returns edit page" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:comment) {create :comment, valid_attributes}

    context "when log in by admin" do
      let!(:user_admin) {create :user, is_admin: true}
      before {session[:user_id] = user_admin.id}
      it "delete comment success" do
        expect {delete :destroy, params: {review_id: review.id, id: comment.id}
        }.to change(Comment, :count)
      end
    end

    context "when log in by user created comment" do
      it "delete comment success" do
        expect {delete :destroy, params: {review_id: review.id, id: comment.id}
        }.to change(Comment, :count)
      end
    end

    context "when log in by another user" do
      let!(:user_another) {create :user}
      before {sign_in user_another}
      it "delete comment fails" do
        expect {delete :destroy, params: {review_id: review.id, id: comment.id}
        }.not_to change(Comment, :count)
      end
    end
  end
end
