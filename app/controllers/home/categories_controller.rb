# frozen_string_literal: true

module Home
  class CategoriesController < HomeController
    def index
      @user = User.all
      @items = Item.all
    end
  end
end
