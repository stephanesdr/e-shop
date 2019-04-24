# frozen_string_literal: true

module Administration
  class UsersController < AdministrationController
    before_action :set_user, only: [:update]

    def index
      @users = User.all
    end

    def update
      @user = User.update(user_params)
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
