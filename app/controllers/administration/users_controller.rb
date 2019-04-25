# frozen_string_literal: true

module Administration
  class UsersController < AdministrationController
    before_action :set_user, only: %i[update edit]

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

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:id, :email, :admin)
    end
  end
end
