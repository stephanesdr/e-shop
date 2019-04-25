# frozen_string_literal: true

module Administration
  class UsersController < AdministrationController
    before_action :set_user, only: %i[update edit]

    def index
      @users = User.all
    end

    def edit; end

    def update
      return unless @user.update(user_params)

      redirect_to administration_users_path, success: "User update successfully"
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
