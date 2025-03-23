require 'rails_helper'

RSpec.describe '購入', type: :system do
  let(:yamada) { create(:user) }

  describe 'カート' do
    before do
      create(:shipping_address, user: yamada)
      cart = create(:cart, user: yamada)
      create(:cart_item, cart: cart, item: create(:item))
      create(:cart_item, cart: cart, item: create(:item))
      sign_in yamada, scope: :user
    end

    it '購入できる' do
      visit users_cart_path

      fill_in '配送日', with: 5.business_days.from_now
      select '14-16', from: '配送時間帯'

      expect do
        click_on '購入する'

        expect(page).to have_content '購入が完了しました'
        expect(page).to have_current_path items_path
      end.to change(Purchase, :count).by(1).and change(PurchaseItem, :count).by(2).and change(Shipping, :count).by(1)
    end
  end

  describe '購入履歴' do
    let(:purchase) { create(:purchase, user: yamada, shipping_fee: 600, cash_on_delivery_fee: 300, tax: 312, created_at: '2025-01-01 12:00:00') }

    before do
      create(:purchase_item, purchase: purchase, price: 1000, item: create(:item, name: 'スイカ'))
      create(:purchase_item, purchase: purchase, price: 2000, item: create(:item, name: 'メロン'))
      delivery_time_slot = DeliveryTimeSlot.find_by(name: '14-16')
      prefecture = Prefecture.find_by(name: '沖縄県')
      create(:shipping, purchase: purchase, delivery_date: '2025-01-14', delivery_time_slot: delivery_time_slot,
                        last_name: '山田', first_name: '太郎', tel: '09012345678', post_code: '9000001',
                        prefecture: prefecture, city: '那覇市', other_address: '1-1-1')
      sign_in yamada, scope: :user
    end

    it '購入履歴の一覧が表示される' do
      visit users_purchases_path

      expect(page).to have_content '購入履歴'
      expect(page).to have_content '2025/01/01 12:00'
      expect(page).to have_content '4,212円'
    end

    it '購入履歴の詳細が表示される' do
      visit users_purchase_path(purchase)

      # 購入詳細
      expect(page).to have_content 'スイカ'
      expect(page).to have_content '1,000円'
      expect(page).to have_content 'メロン'
      expect(page).to have_content '2,000円'

      # 支払情報
      expect(page).to have_content '3,000円'
      expect(page).to have_content '600円'
      expect(page).to have_content '300円'
      expect(page).to have_content '312円'
      expect(page).to have_content '4,212円'

      # 配送日時
      expect(page).to have_content '2025年01月14日(火)'
      expect(page).to have_content '14-16'

      # 配送先
      expect(page).to have_content '山田太郎'
      expect(page).to have_content '09012345678'
      expect(page).to have_content '〒9000001'
      expect(page).to have_content '沖縄県那覇市1-1-1'
    end
  end
end
