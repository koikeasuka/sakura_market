class Shipping < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :purchase
  belongs_to :prefecture
  belongs_to :delivery_time_slot, optional: true

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :post_code, presence: true
  validates :tel, presence: true
  validates :post_code, presence: true, format: { with: /\A\d{3}[-]?\d{4}\z/ }
  validates :city, presence: true
  validates :other_address, presence: true
end
