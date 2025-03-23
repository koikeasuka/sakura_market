module ShippingHelper
  def formatted_delivery_date(delivery_date)
    delivery_date ? (l delivery_date, format: :long) : '指定なし'
  end

  def formatted_delivery_time_slot(delivery_time_slot)
    delivery_time_slot ? delivery_time_slot.name : '指定なし'
  end
end
