# frozen_string_literal: true

module Home
  class CategoriesController < HomeController
    def index
      @categories = Category.all
    end
  end
end
