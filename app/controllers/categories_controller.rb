class CategoriesController < ApplicationController
  before_action :find_category, only: %i(show)

  def show
    @categories = Category.select_custom.order_lft_asc
    tours = []
    @category.self_and_descendants.each do |category|
      tours += category.tours
    end
    @tours = Kaminari.paginate_array(tours).page(params[:page]).per Settings.tours.per_page
  end

  private

  def find_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t "app.category.not_found"
    redirect_to tours_path
  end
end
