module CartHelper
  def unable_to_purchase?(cart)
    cart.has_close_item? || current_user.shipping_address.nil?
  end
end
