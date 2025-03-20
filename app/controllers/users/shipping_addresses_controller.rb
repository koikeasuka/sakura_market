class Users::ShippingAddressesController < Users::ApplicationController
  before_action :set_shipping_address, only: %i[edit update]

  def new
    @shipping_address = current_user.build_shipping_address
  end

  def edit
  end

  def create
    @shipping_address = current_user.build_shipping_address(shipping_address_params)

    if @shipping_address.save
      redirect_to edit_users_shipping_address_path, notice: '配送先住所を登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @shipping_address.update(shipping_address_params)
      redirect_to items_path, notice: '配送先住所を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_shipping_address
    @shipping_address = current_user.shipping_address
  end

  def shipping_address_params
    params.require(:shipping_address).permit(
      :last_name,
      :first_name,
      :tel,
      :post_code,
      :prefecture_id,
      :city,
      :other_address
    )
  end
end
