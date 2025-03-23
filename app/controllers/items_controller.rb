class ItemsController < ApplicationController
  def index
    @pagy, @items = pagy(Item.where(is_published: true).order(position: :asc).with_attached_product_photo)
  end

  def show
    @item = Item.is_published.find(params[:id])
  end
end
