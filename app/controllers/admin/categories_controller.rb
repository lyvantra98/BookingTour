class Admin::CategoriesController < Admin::BaseController
  before_action :load_cate, except: %i(new index create)
  def index
    @q = Category.ransack params[:q]
    @categories = @q.result(distinct: true)
      .show_cate.select_cate_desc.includes(:tours)
      .page(params[:page]).per Settings.page.page_number_admin
  end

  def new
    @category = Category.new
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def edit; end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "create_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def update
    if @category.update category_params
      flash[:success] = t "update_success"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    begin
      if @category.tours.any?
        flash[:danger] = t "can_not_delete_category"
      else
        @category.destroy
        flash[:success] = t "delete_success"
      end
    rescue
      flash[:danger] = t "not_delete"
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit :name, :parent_id
  end

  def load_cate
    @category = Category.find_by id: params[:id]
    return if @category.present?
    flash[:danger] = t "not_category"
    redirect_to root_path
  end
end
