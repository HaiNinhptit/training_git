class DailyMailer < ApplicationMailer
  default from: 'haininh@zinza.com'

  def send_daily_mailer(user)
    @user = user
    @list_products = Order.orders_in_day
    mail(to: @user.email, subject: 'Daily mailer')
  end
end
