class Admin::ReviewsController < Admin::BaseController
  before_action :load_review, only: %i(destroy show)

  def index
    @q = Review.ransack params[:q]
    @reviews = @q.result(distinct: true).show_review.page(params[:page])
      .per Settings.page.page_number_admin
  end

  def show; end

  def destroy
    begin
      @review.destroy
      flash[:success] = t "delete_success"
    rescue
      flash[:danger] = t "not_delete"
    end
    redirect_to admin_reviews_path
  end

  private

  def load_review
    @review = Review.find_by id: params[:id]
    return if @review.present?
    flash[:danger] = t "review.not_review"
    redirect_to root_path
  end
end
