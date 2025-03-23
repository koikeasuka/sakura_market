require 'rails_helper'

RSpec.describe 'カート', type: :system do
  let(:yamada) { create(:user) }

  before { sign_in yamada, scope: :user }

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

    context '配送先住所が登録されている場合' do
      it '配送先住所が表示される' do
        prefecture = Prefecture.find_by(name: '沖縄県')
        create(:shipping_address, user: yamada, last_name: '山田', first_name: '太郎', tel: '09012345678',
                                  post_code: '9000001', prefecture: prefecture, city: '那覇市', other_address: '1-1')

        visit users_cart_path

        expect(page).to have_content '配送先住所'
        expect(page).to have_content '山田太郎'
        expect(page).to have_content '09012345678'
        expect(page).to have_content '〒9000001'
        expect(page).to have_content '沖縄県那覇市1-1'
      end
    end

    context '配送先住所が登録されていない場合' do
      it '登録画面へのリンクが表示され、購入に進めない' do
        visit users_cart_path

        expect(page).to have_content '配送先住所の登録がされていません。配送先住所の登録がないと購入できません。'
        expect(page).to have_link '新規登録', href: new_users_shipping_address_path
        expect(page).to have_button '購入する', disabled: true
      end
    end
  end

  context 'カートに商品が入っていない場合' do
    it '商品一覧画面へのリンクが表示される' do
      visit users_cart_path

      expect(page).to have_link 'TOPページへ', href: items_path
    end
  end

  context 'カート内に非公開の商品が入っている場合' do
    before do
      cart = create(:cart, user: yamada)
      item = create(:item, name: 'バナナ', price: 150, is_published: true)
      create(:cart_item, cart: cart, item: item)
      item.update!(is_published: false)
    end

    it '削除するよう促され、購入に進めない' do
      visit users_cart_path

      expect(page).to have_content '購入できない商品のためカートから削除してください'
      expect(page).to have_button '購入する', disabled: true
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
