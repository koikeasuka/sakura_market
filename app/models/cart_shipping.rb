class CartShipping
  include ActiveModel::Model
  include ActiveModel::Attributes
  extend ActiveHash::Associations::ActiveRecordExtensions

  attribute :delivery_date, :date
  attribute :delivery_time_slot_id, :string

  def persisted?
    false
  end
end
