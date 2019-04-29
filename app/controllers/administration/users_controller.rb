# frozen_string_literal: true

module Administration
  class UsersController < AdministrationController
    before_action :set_user, only: %i[update edit destroy]

    def index
      @users = User.all
    end

    def edit; end

    def update
      if @user.update(user_params)
        flash[:notice] = "User updated successfully"
      else
        flash[:danger] = "User update abort"
      end
      redirect_to administration_users_path
    end

    def destroy
      CartItem.where(cart_id: @user.cart.id).each { |cart_item| CartItem.delete(cart_item) }
      Cart.delete(@user.cart)
      Order.where(user_id: @user.id).each do |order|
        ItemOrder.where(order_id: order.id).each { |item_order| ItemOrder.delete(item_order) }
        Order.delete(order)
      end
      Profile.delete(@user.profile)
      if User.delete(@user)
        flash[:notice] = "User deleted successfully"
      else
        flash[:danger] = "User delete abort"
      end
      redirect_to request.referer
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:id, :email, :admin)
    end
  end
end
