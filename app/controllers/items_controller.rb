class ItemsController < ApplicationController
  def index
    @items = Item.where(is_published: true).order(position: :asc).page(params[:page]).with_attached_product_photo
  end

  def show
    @item = Item.find(params[:id])
  end
end
