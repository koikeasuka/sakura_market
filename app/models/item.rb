class Item < ApplicationRecord
  has_one_attached :product_photo do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :image, resize_to_fit: [300, 300]
  end
  has_many :cart_items, dependent: :destroy
  has_many :purchase_items, dependent: :restrict_with_exception
  acts_as_list

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  before_validation :set_position

  scope :is_published, -> { where(is_published: true) }

  private

  def set_position
    self.position ||= Item.count + 1
  end
end
