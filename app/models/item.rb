class Item < ApplicationRecord
  has_one_attached :image, resize_to_limit: [100, 100]

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
