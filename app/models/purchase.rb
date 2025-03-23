class Purchase < ApplicationRecord
  belongs_to :user
  has_one :shipping, dependent: :restrict_with_exception
  has_many :purchase_items, dependent: :restrict_with_exception
  has_many :items, through: :purchase_items

  def total_price
    sub_total + shipping_fee + cash_on_delivery_fee + tax
  end

  def sub_total
    purchase_items.sum(&:price)
  end
end
