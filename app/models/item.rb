class Item < ApplicationRecord
  has_one_attached :product_photo do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :image, resize_to_fit: [300, 300]
  end
  acts_as_list

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
