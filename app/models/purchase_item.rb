class PurchaseItem < ApplicationRecord
  belongs_to :purchase
  belongs_to :item

  validates :price, presence: true
end
