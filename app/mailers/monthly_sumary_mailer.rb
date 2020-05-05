class MonthlySumaryMailer < ActionMailer::Base
  default from: ENV["EMAIL"]

  def monthly_sumary_mailer bookings
    users = User.select_admin
    if users.present?
      @bookings = bookings
      users.each do |user|
        mail to: user.email, subject: t("app_name")
      end
    else
      flash[:danger] = t "not_user"
    end
  end
end
