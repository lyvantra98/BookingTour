class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_tour, only: %i(create)
  before_action :correct_user, only: %i(edit update)

  def index
    @bookings = current_user.bookings.includes(:tour)
      .page(params[:page]).per Settings.tours.per_page
    redirect_to :root if @bookings.nil?
  end

  def create
    @booking = @tour.bookings.build booking_params
    @booking.user_id = current_user.id
    if @booking.save
      flash[:success] = t "app.booking.booking_success"
      redirect_to @tour
    else
      @reviews = @tour.reviews
      render "tours/show"
    end
  end

  def edit; end

  def update
    if @booking.update booking_params
      flash[:success] = t "update_success"
      redirect_to bookings_path
    else
      flash[:danger] = t "update_fails"
      render :edit
    end
  end

  private

  def booking_params
    params.require(:booking).permit :user_id, :status, :number_people
  end

  def find_tour
    @tour = Tour.find_by id: params[:tour_id]
    return if @tour
    flash[:danger] = t "tours.not_tour"
    redirect_to :root
  end

  def correct_user
    @booking = current_user.bookings.find_by id: params[:id]
    redirect_to :root if @booking.nil?
  end
end
