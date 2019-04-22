# frozen_string_literal: true

module Home
  class CategoriesController < HomeController
    def index
      @user = User.all
    end
  end
end
