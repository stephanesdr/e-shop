# frozen_string_literal: true

module Home
  class PaymentsController < HomeController
    def index
      @user = current_user
      @cart = current_user.cart
      @amount = @cart.sum_price * 100
      @cart = Cart.find(current_user.cart.id)
      @profile = Profile.find(current_user.profile.id)
    end
  end
end
