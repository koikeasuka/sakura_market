class CartShipping
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :delivery_date, :date
  attribute :delivery_time_slot_id, :integer

  def persisted?
    false
  end
end
