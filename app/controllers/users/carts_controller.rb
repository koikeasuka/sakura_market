class Users::CartsController < Users::ApplicationController
  def show
    @cart = current_cart
    @cart_shipping = CartShipping.new
  end
end
