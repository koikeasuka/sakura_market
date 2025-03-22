class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items

  def total_price
    (sub_total + shipping_fee + cash_on_delivery_fee) * 1.08
  end

  def sub_total
    items.sum(&:price)
  end

  def shipping_fee
    # 送料は6商品毎に600円追加する
    shipping_count = (items.size / 6.0).ceil
    shipping_count * 600
  end

  def cash_on_delivery_fee
    # 代引き手数料は小計に応じて、代引き手数料テーブルから参照
    CashOnDeliveryFee.extract_fee(sub_total).fee
  end

  def tax
    # 消費税は小数点以下は切り捨て
    ((sub_total + shipping_fee + cash_on_delivery_fee) * 0.08).floor
  end
end
