require 'rails_helper'

RSpec.describe 'カート', type: :system do
  let(:yamada) { create(:user) }

  before { sign_in yamada, scope: :user }

  describe '詳細' do
    context 'カート内に商品が入っている場合' do
      before do
        cart = create(:cart, user: yamada)
        create(:cart_item, cart: cart, item: create(:item, name: 'バナナ', price: 150))
        create(:cart_item, cart: cart, item: create(:item, name: 'りんご', price: 250))
      end

      it '商品が表示される' do
        visit users_cart_path

        expect(page).to have_content 'バナナ'
        expect(page).to have_content '150円'
        expect(page).to have_content 'りんご'
        expect(page).to have_content '250円'
        expect(page).to have_content '400円' # 小計
        expect(page).to have_content '600円' # 送料
        expect(page).to have_content '300円' # 代引き手数料
        expect(page).to have_content '104円' # 消費税
        expect(page).to have_content '1,404円' # 合計
      end

      it '商品を削除できる', :js do
        visit users_cart_path

        expect do
          within first('.cart-item') do
            click_on '削除'
          end
          page.accept_confirm '削除してもよろしいですか'

          expect(page).to have_content 'カートから削除しました'
          expect(page).to have_current_path users_cart_path
          expect(page).not_to have_content 'バナナ'
          expect(page).not_to have_content '150円'
          expect(page).to have_content 'りんご'
          expect(page).to have_content '250円'
        end.to change(CartItem, :count).by(-1)
      end
    end

    context 'カートに商品が入っていない場合' do
      it '商品一覧画面へのリンクが表示される' do
        visit users_cart_path

        expect(page).to have_link 'TOPページへ', href: items_path
      end
    end
  end

  describe '商品詳細' do
    let(:item) { create(:item) }

    it 'カートに追加できる' do
      visit item_path(item)

      expect do
        click_on 'カートに入れる'

        expect(page).to have_content 'カートに追加しました'
        expect(page).to have_current_path items_path

        cart_item = yamada.cart.cart_items.last
        expect(cart_item).to have_attributes(item: item)
      end.to change(CartItem, :count).by(1)
    end
  end
end
