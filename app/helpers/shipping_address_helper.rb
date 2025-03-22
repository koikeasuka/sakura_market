module ShippingAddressHelper
  def full_name(shipping_address)
    shipping_address.last_name + shipping_address.first_name
  end

  def address(shipping_address)
    shipping_address.prefecture.name + shipping_address.city + shipping_address.other_address
  end
end
