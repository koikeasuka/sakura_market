class Users::PurchasesController < Users::ApplicationController
  def index
    @purchases = current_user.purchases.order(id: :desc)
  end

  def show
    @purchase = current_user.purchases.find(params[:id])
  end

  def create
    @purchase = current_cart.purchase(permit_params)
    if @purchase
      redirect_to items_path, notice: '購入が完了しました。'
    else
      redirect_to users_cart_path, notice: current_cart.errors.full_messages.join(', ')
    end
  end

  private

  def permit_params
    params.require(:cart_shipping).permit(:delivery_date, :delivery_time_slot_id)
  end
end
