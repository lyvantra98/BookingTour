class SendEmailMonthJob < ActiveJob::Base
  queue_as :default

  def perform
    @bookings = Booking.select_between_date
    MonthlySumaryMailer.monthly_sumary_mailer(@bookings).deliver_now
  end
end
