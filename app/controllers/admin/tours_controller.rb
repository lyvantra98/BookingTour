class Admin::ToursController < Admin::BaseController
  before_action :load_tour, except: %i(new index create)
  before_action :load_cate, except: %i(index show destroy)

  def index
    @q = Tour.ransack params[:q]
    @tours = @q.result(distinct: true)
      .select_custom.show_tour_desc
      .page(params[:page]).per Settings.page.page_number_admin
  end

  def new
    @tour = Tour.new
    @image = @tour.images.build
  end

  def create
    @tour = Tour.new tour_params
    ActiveRecord::Base.transaction do
      @tour.save
      params[:images]["image_link"].each do |image|
        @image = Image.create! tour_id: @tour.id, image_link: image
      end
      flash[:success] = t "create_success"
      redirect_to admin_tours_path
    end
    rescue Exception
      flash[:danger] = t "not_image"
      render :new
  end

  def show
    @images = @tour.images.select_image
      .page(params[:page]).per Settings.page.page_number_img
  end

  def edit; end

  def update
    ActiveRecord::Base.transaction do
      @tour.update tour_params
      params[:images]["image_link"].each do |image|
        @image = Image.create! tour_id: @tour.id, image_link: image
      end
      flash[:success] = t "update_success"
      redirect_to admin_tours_path
    end
    rescue Exception
      flash[:danger] = t "not_image"
      render :edit
  end

  def destroy
    begin
      @tour.destroy
      flash[:success] = t "delete_success"
    rescue
      flash[:danger] = t "not_delete"
    end
    redirect_to admin_tours_path
  end

  def status
    if @tour.close?
      @tour.update! status: "open"
    elsif @tour.open?
      @tour.update! status: "close"
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def tour_params
    params.require(:tour).permit :status, :name, :date_from, :date_to, :location_from, :location_to, :price,
      :max_people,:min_people, :description, :category_id
  end

  def load_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour.present?
    flash[:danger] = t "tours.not_tour"
    redirect_to root_path
  end

  def load_cate
    @categories = Category.show_cate
  end
end
