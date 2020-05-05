class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform booking
    @booking = booking
    ExampleMailer.sample_email(@booking).deliver_now
  end
end
