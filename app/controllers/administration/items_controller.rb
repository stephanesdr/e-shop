# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    # before_action :admin_authorization
    def show
      @item = Item.find(params[:id])
    end

    def index
      @items = Item.all
    end

    def new
      @categories = Category.all
    end

    def create
      @item = Item.create(name: params[:name], description: params[:description], percentage_discount: params[:percentage_discount], price: params[:price] )
      @item.picture.attach(params[:picture])
      @item.percentage_discount.positive? ? @item.update(discount: true) : @item.update(discount: false)
      if !params[:category_ids].nil?
        @categories = Category.find(params[:category_ids])
        @categories.each { |category| CategoryItem.create(item_id: @item.id, category_id: category.id) } if !@categories.empty?
      end
      if @item.errors.any?
        flash[:danger] = "Problème avec la création de l'item."
        redirect_to request.referer
      else
        redirect_to administration_items_path
        flash[:notice] = "Item créé avec succès."
      end
    end

    def destroy
      @item = Item.find(params[:id])
      CartItem.where(item_id: @item.id).each { |cart_item| CartItem.delete(cart_item) }
      CategoryItem.where(item_id: @item.id).each { |category_item| CategoryItem.delete(category_item) }
      ItemOrder.where(item_id: @item.id).each { |order_item| ItemOrder.delete(order_item) }
      Item.delete(@item)
      redirect_to request.referer
    end

    def edit
      @categories = Category.all
      @item = Item.find(params["id"])
    end

    def update
      @item = Item.find(params["id"])

      @item.update(name: params[:item][:name], description: params[:item][:description], price: params[:item][:price], percentage_discount: params[:item][:percentage_discount])
      @item.percentage_discount.positive? ? @item.update(discount: true) : @item.update(discount: false)

      CategoryItem.where(item_id: @item.id).each { |category_item| CategoryItem.delete(category_item) }
      if !params[:category_ids].nil?
        @categories = Category.find(params[:category_ids])
        @categories.each { |category| CategoryItem.create(item_id: @item.id, category_id: category.id) } if !@categories.empty?
      end

      if @item.errors.any?
        flash[:danger] = "L'édition d'annonce n'a pas fonctionné."
        redirect_to request.referer
      else
        flash[:notice] = "Votre évènement a bien été édité."
        redirect_to administration_items_path
      end
    end

    private

    def admin_authorization
      redirect_to root_path unless current_user.admin
      flash[:notice] = "Vous devez être connecté en tant qu'admin" unless current_user.admin
    end
  end
end
