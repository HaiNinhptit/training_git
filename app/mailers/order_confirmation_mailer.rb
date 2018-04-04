class OrderConfirmationMailer < ApplicationMailer
  default from: ENV['MAIL_USER_NAME']
  layout 'mailer'

  def order_confirmation(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: 'Email order confirmation')
  end
end
