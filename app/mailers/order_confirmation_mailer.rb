class OrderConfirmationMailer < ApplicationMailer
  default from: 'haininh@zinza.com'

  def order_confirmation(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: 'Email order confirmation')
  end
end
