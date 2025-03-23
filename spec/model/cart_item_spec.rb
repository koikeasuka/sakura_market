require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe '#item_must_be_published' do
    let(:suzuki) { create(:user) }
    let(:item) { create(:item) }

    context '商品の詳細ページを開いた後に、商品が非公開になった場合' do
      let(:cart) { create(:cart, user: suzuki) }

      it 'カートに入れることができない' do
        item.update!(is_published: false)
        cart_item = build(:cart_item, cart: cart, item: item)

        expect(cart_item).not_to be_valid
        expect(cart_item.errors.full_messages).to include('非公開の商品のためカートに追加できません')
      end
    end
  end
end
