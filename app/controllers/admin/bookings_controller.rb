class Admin::BookingsController < Admin::BaseController
  before_action :load_booking, except: %i(new index create)

  def index
    @q = Booking.ransack params[:q]
    @bookings = @q.result(distinct: true)
      .select_booking.includes(:tour)
      .page(params[:page]).per Settings.page.page_number_admin
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def edit; end

  def update
    if @booking.update booking_params
      if @booking.accepted?
        SendEmailJob.set(wait: Settings.number.time_send_mail.seconds).perform_later @booking
      end
      flash[:success] = t "update_success"
      redirect_to admin_bookings_path
    else
      render :edit
    end
  end

  private

  def booking_params
    params.require(:booking).permit :status
  end

  def load_booking
    @booking = Booking.find_by id: params[:id]
    return if @booking.present?
    flash[:danger] = t "not_booking"
    redirect_to root_path
  end
end
