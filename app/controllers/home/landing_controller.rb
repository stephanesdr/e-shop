# frozen_string_literal: true

module Home
  class LandingController < HomeController
    def index
      @categories = Category.all
      @items = Item.all
    end
  end
end
