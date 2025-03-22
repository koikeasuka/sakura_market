class Purchase < ApplicationRecord
  belongs_to :user
  has_one :shipping, dependent: :restrict_with_exception
  has_many :purchase_items, dependent: :restrict_with_exception
  has_many :items, through: :purchase_items
end
