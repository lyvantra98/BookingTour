class Admin::DasboardController < Admin::BaseController
  def index
    @bookings = Booking.select_booking
    @tours = Tour.select_custom
  end
end
