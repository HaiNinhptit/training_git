class DailyMailer < ApplicationMailer
  default from: ENV['MAIL_USER_NAME']
  layout 'mailer'

  def send_daily_mailer(user)
    @user = user
    @total = Order.revenue_in_day
    mail(to: @user.email, subject: 'Daily mailer')
  end
end
