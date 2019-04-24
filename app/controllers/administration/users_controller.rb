# frozen_string_literal: true

module Administration
  class UsersController < AdministrationController
    def index
      @users = User.all
    end
  end
end
