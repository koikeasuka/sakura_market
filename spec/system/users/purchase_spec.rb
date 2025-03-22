require 'rails_helper'

RSpec.describe '購入', type: :system do
  let(:yamada) { create(:user) }

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
