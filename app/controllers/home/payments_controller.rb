# frozen_string_literal: true

module Home
  class PaymentsController < HomeController
    def index
      @user = current_user
      @cart = current_user.cart
      @amount = @cart.sum_price
      @cart = Cart.find(current_user.cart.id)
      @profile = Profile.find(current_user.profile.id)
    end

    def edit
      @profile = Profile.find(current_user.profile.id)
    end

    def update
      @profile = Profile.find(current_user.profile.id)
      @profile.update(first_name: params['profile']['first_name'], last_name: params['profile']['last_name'], phone_number: params['profile']['phone_number'], street: params['profile']['street'], postal_code: params['profile']['postal_code'], city: params['profile']['city'])
      if @profile.errors.any?
        flash[:danger] = "Profile edition failed"
      else
        flash[:notice] = "Profile edition succeed"
      end
      redirect_to home_payments_path(current_user.cart.id)
    end
  end
end
