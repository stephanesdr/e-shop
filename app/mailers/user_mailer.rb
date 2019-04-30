# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def order_email(order)
    @order = order
    @user = order.user
    mail(to: @user.email, subject: 'Confirmation de commande')
  end
end
