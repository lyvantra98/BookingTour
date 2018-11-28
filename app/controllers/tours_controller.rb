class ToursController < ApplicationController
  before_action :find_tour, only: %i(show)

  def index
    @q = Tour.ransack params[:q]
    @categories = Category.select_custom.order_lft_asc
    @tours = @q.result.select_custom.show_tour_desc.is_open
      .page(params[:page]).includes(:images).per Settings.tours.per_page
  end

  def show
    @booking = Booking.new
    @reviews = @tour.reviews
  end

  private

  def find_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour
    flash[:danger] = t "tours.not_found"
    redirect_to tours_path
  end
end
