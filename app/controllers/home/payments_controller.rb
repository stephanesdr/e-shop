# frozen_string_literal: true

module Home
  class PaymentsController < HomeController
    def index
      @cart = Cart.find(current_user.cart.id)
      @profile = Profile.find(current_user.profile.id)
    end
  end
end
