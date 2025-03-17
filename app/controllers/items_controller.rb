class ItemsController < ApplicationController
  def index
    @items = Item.order(position: :asc).page(params[:page]).with_attached_product_photo
  end
end
