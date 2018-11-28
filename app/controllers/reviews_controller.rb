class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: %i(show)
  before_action :find_tour, only: %i(new create)
  before_action :correct_user, only: %i(edit update)
  before_action :find_review, only: %i(show destroy)

  def index
    @reviews = current_user.reviews.includes(:tour).page(params[:page]).per Settings.tours.per_page
    redirect_to :root if @reviews.nil?
  end

  def show
    @comments = @review.comments.order_desc.roots.includes(:user)
    @comment = Comment.new
  end

  def new
    @review = Review.new
  end

  def create
    @review = @tour.reviews.build review_params
    @review.user_id = current_user.id
    if @review.save
      flash[:success] = t "app.review.success"
      redirect_to @tour
    else
      flash[:danger] = t "app.review.fail"
      render "tours/show"
    end
  end

  def edit; end

  def update
    if @review.update review_params
      flash[:success] = t "update_success"
      redirect_to @review
    else
      flash[:danger] = t "update_fails"
      render :edit
    end
  end

  def destroy
    begin
      @review.destroy
      flash[:success] = t "delete_success"
    rescue
      flash[:danger] = t "not_delete"
    end
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit :user_id, :title, :content
  end

  def find_tour
    @tour = Tour.find_by id: params[:tour_id]
    return if @tour
    flash[:danger] = t "tours.not_tour"
    redirect_to :root
  end

  def correct_user
    @review = current_user.reviews.find_by id: params[:id]
    redirect_to :root if @review.nil?
  end

  def find_review
    @review = Review.find_by id: params[:id]
    return if @review
    flash[:danger] = t "app.review.not_review"
    redirect_to :root
  end
end
