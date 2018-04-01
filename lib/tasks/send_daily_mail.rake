namespace :send_daily_mail do
  desc "Email sales daily"
  task daily_mail: :environment do
    user = AdminUser.find_by(id: 1)
    DailyMailer.send_daily_mailer(user).deliver_now
  end
end
