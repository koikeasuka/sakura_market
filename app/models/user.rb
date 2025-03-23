class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_one :shipping_address, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :purchases, dependent: :destroy
end
