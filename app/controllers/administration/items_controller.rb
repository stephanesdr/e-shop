# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    # before_action :admin_authorization
    def index
      @items = Item.all
    end

    def destroy
      @item = Item.find(params[:id])
      CartItem.where(item_id: @item.id).each { |cart_item| CartItem.delete(cart_item) }
      CategoryItem.where(item_id: @item.id).each { |category_item| CategoryItem.delete(category_item) }
      # OrderItem.where(item_id: @item.id).each {|order_item| OrderItem.delete(order_item) }
      Item.delete(@item)
      redirect_to request.referer
    end

    private

    def admin_authorization
      redirect_to root_path unless current_user.admin
      flash[:notice] = "Vous devez être connecté en tant qu'admin" unless current_user.admin
    end
  end
end