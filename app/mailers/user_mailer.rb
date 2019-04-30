# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def order_email(order)
    @order = order
    @user = order.user
    mail(to: @user.email, subject: 'Confirmation de commande')
  end

  def shipped_email(order)
    @order = order
    @user = order.user
    mail(to: @user.email, subject: "Votre colis est en cours d'acheminement")
  end

  def delivered_email(order)
    @order = order
    @user = order.user
    mail(to: @user.email, subject: "Votre colis est arrivé !")
  end
end
