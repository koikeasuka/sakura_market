class Users::CartItemsController < Users::ApplicationController
  def create
    cart_item = current_cart.cart_items.new(permitted_params)
    if cart_item.save
      redirect_to items_path, notice: 'カートに追加しました'
    else
      redirect_to items_path, notice: 'カートに追加できませんでした'
    end
  end

  def destroy
    current_cart.cart_items.find(params[:id]).destroy!
    redirect_to current_carts_path, notice: 'カートから削除しました', status: :see_other
  end

  private

  def permitted_params
    params.require(:cart_item).permit(:item_id)
  end
end
