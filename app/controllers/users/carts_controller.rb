class Users::CartsController < Users::ApplicationController
  def show
    @cart = current_cart
  end
end
