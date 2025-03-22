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

  def purchase(cart_shipping)
    unless cart_items.exists?
      errors.add(:base, 'カートが空のため購入できませんでした')
      return false
    end

    purchase = build_purchase_with_associations(cart_shipping)

    transaction do
      purchase.save!
      destroy!
    end
    purchase
  end

  def build_purchase_with_associations(cart_shipping)
    purchase = user.purchases.build(shipping_fee: shipping_fee, cash_on_delivery_fee: cash_on_delivery_fee, tax: tax)

    cart_items.each do |cart_item|
      purchase.purchase_items.build(item: cart_item.item, price: cart_item.item.price)
    end

    ship_add = user.shipping_address
    purchase.build_shipping(last_name: ship_add.last_name, first_name: ship_add.first_name, tel: ship_add.tel, post_code: ship_add.post_code,
                            prefecture_id: ship_add.prefecture_id, city: ship_add.city, other_address: ship_add.other_address,
                            delivery_date: cart_shipping[:delivery_date], delivery_time_slot_id: cart_shipping[:delivery_time_slot_id])

    purchase
  end
end
