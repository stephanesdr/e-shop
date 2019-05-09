# frozen_string_literal: true

module Home
  class SearchController < HomeController
    def create
      item_name = params[:search].capitalize
      if Item.where(name: item_name).exists?
        item = Item.find_by(name: item_name)
        redirect_to home_item_path(item.id)
      else
        redirect_to home_search_index_path
      end
    end
  end
end
