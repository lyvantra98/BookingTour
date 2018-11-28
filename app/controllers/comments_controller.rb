class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_review
  before_action :find_comment_for_destroy, only: %i(destroy)
  before_action :allow_destroy, only: %i(destroy)
  before_action :find_comment_for_edit, only: %i(edit update)

  def create
    @comment = @review.comments.build comment_params
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = t "app.comment.success"
    else
      flash[:danger] = t "app.comment.fails"
    end
    redirect_to @review
  end

  def edit; end

  def update
    if @comment.update comment_params
      flash[:success] = t "update_success"
      redirect_to @review
    else
      flash[:danger] = t "update_fails"
      render :edit
    end
  end

  def destroy
    begin
      @comment.destroy
      flash[:success] = t "delete_success"
    rescue
      flash[:danger] = t "not_delete"
    end
    redirect_to @review
  end

  private

  def comment_params
    params.require(:comment).permit :user_id, :parent_id, :content
  end

  def find_comment_for_edit
    @comment = current_user.comments.find_by id: params[:id]
    return if @comment
    flash[:danger] = t "error"
    redirect_to :root
  end

  def find_comment_for_destroy
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:danger] = t "error"
    redirect_to :root
  end

  def find_review
    @review = Review.find_by id: params[:review_id]
    return if @review
    flash[:danger] = t "error"
    redirect_to :root
  end

  def allow_destroy
    return if current_user.id == @comment.user_id || current_user.is_admin?
    flash[:danger] = t "not_access"
    redirect_to root_path
  end

end
