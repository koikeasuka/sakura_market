class ItemsController < ApplicationController
  def index
    @items = Item.order(position: :asc).with_attached_product_photo
  end
end
