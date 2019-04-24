# frozen_string_literal: true

class ItemsController < ApplicationController
  # before_action :admin_authorization
  def index
    @items = Item.all
  end

  def new
    @categories = Category.all
  end

  def create
    @item = Item.create(name: params[:name], description: params[:description], percentage_discount: params[:percentage_discount], price: params[:price] )
    @item.percentage_discount.positive? ? @item.update(discount: true) : @item.update(discount: false)
    @categories = Category.find(params[:category_ids])
    @categories.each { |category| CategoryItem.create(item_id: @item.id, category_id: category.id) }
    if @item.errors.any?
      flash[:danger] = "Problème avec la création de l'item."
      redirect_to request.referer
    else
      flash[:notice] = "Item créé avec succès."
      redirect_to items_path
    end
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
