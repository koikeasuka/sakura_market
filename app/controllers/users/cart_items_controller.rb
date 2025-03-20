class Users::CartItemsController < Users::ApplicationController
  def create
    cart_item = current_cart.cart_items.build(cart_item_params)
    if cart_item.save
      redirect_to items_path, notice: 'カートに追加しました'
    else
      redirect_to items_path, notice: 'カートに追加できませんでした'
    end
  end

  def destroy
    current_cart.cart_items.find(params[:id]).destroy!
    redirect_to users_cart_path, notice: 'カートから削除しました', status: :see_other
  end

  private

  def cart_item_params
    params.permit(:item_id)
  end
end
