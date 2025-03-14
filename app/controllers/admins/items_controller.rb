class Admins::ItemsController < Admins::ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  def index
    @items = Item.order(id: :desc)
  end

  def show
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to admins_items_path, notice: '商品の登録が完了しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      redirect_to admins_item_path(@item), notice: '商品情報を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy!
    redirect_to admins_items_path, status: :see_other, notice: '商品を削除しました'
  end

  private

  def set_item
    @item = Item.find(params.expect(:id))
  end

  def item_params
    params.require(:item).permit(:name, :description, :price)
  end
end
