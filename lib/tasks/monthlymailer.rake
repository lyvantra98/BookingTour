namespace :job do
  desc "send email in last month"
  task mailmonth: :environment do
    SendEmailMonthJob.perform_now
  end
end
