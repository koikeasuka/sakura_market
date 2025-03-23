class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item

  validate :item_must_be_published

  private

  def item_must_be_published
    errors.add(:base, '非公開の商品のためカートに追加できません') unless item.is_published
  end
end
