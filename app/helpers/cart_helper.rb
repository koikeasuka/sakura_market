module CartHelper
  def delivery_time_slot(item)
    DeliveryTimeSlot.map { |d| [d.name, d.id] }
  end
end
