# frozen_string_literal: true

module Home
  class ItemsController < HomeController
    def show
      @item = Item.find(params[:id])
    end
  end
end
