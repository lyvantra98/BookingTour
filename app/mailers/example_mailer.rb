class ExampleMailer < ActionMailer::Base
  default from: ENV["EMAIL"]

  def sample_email booking
    @booking = booking
    mail to: @booking.user.email, subject: t("app_name")
  end
end
