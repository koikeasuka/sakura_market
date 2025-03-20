require 'rails_helper'

RSpec.describe '配送先住所', type: :system do
  let(:yamada) { create(:user) }
  let(:prefecture) { Prefecture.find_by(name: '沖縄県') }

  describe '詳細' do
    before { sign_in yamada, scope: :user }

    context '配送先住所登録している場合' do
      before do
        create(:shipping_address, user: yamada, last_name: '山田', first_name: '太郎', tel: '09012345678',
                                  post_code: '9000001', prefecture: prefecture, city: '那覇市', other_address: '1-1')
      end

      it '配送先住所が表示される' do
        visit users_shipping_address_path

        expect(page).to have_content '山田'
        expect(page).to have_content '太郎'
        expect(page).to have_content '09012345678'
        expect(page).to have_content '9000001'
        expect(page).to have_content '沖縄県'
        expect(page).to have_content '那覇市'
        expect(page).to have_content '1-1'
      end
    end

    context '配送先住所未登録の場合' do
      it '登録画面へのリンクが表示される' do
        visit users_shipping_address_path

        expect(page).to have_link '新規登録', href: new_users_shipping_address_path
      end
    end
  end

  describe '新規登録' do
    before { sign_in yamada, scope: :user }

    it '新規登録ができる' do
      visit new_users_shipping_address_path

      fill_in '姓', with: '山田'
      fill_in '名', with: '太郎'
      fill_in '電話番号', with: '09012345678'
      fill_in '郵便番号', with: '9000001'
      select '沖縄県', from: '都道府県'
      fill_in '市区町村', with: '那覇市'
      fill_in 'その他住所', with: '1-1'

      expect do
        click_on '登録する'

        expect(page).to have_content '配送先住所を登録しました'
        expect(page).to have_current_path users_shipping_address_path

        shipping_address = ShippingAddress.last
        expect(shipping_address).to have_attributes(last_name: '山田', first_name: '太郎', tel: '09012345678',
                                                    post_code: '9000001', city: '那覇市', other_address: '1-1')
      end.to change(ShippingAddress, :count).by(1)
    end
  end

  describe '編集' do
    before do
      create(:shipping_address, user: yamada, last_name: '山田', first_name: '太郎', tel: '09012345678',
                                post_code: '9000001', prefecture: prefecture, city: '那覇市', other_address: '1-1')
      sign_in yamada, scope: :user
    end

    it '編集ができる' do
      visit edit_users_shipping_address_path

      fill_in '姓', with: '鈴木'
      fill_in '名', with: '次郎'
      fill_in '電話番号', with: '09087654321'
      fill_in '郵便番号', with: '9000002'
      select '東京都', from: '都道府県'
      fill_in '市区町村', with: '渋谷区'
      fill_in 'その他住所', with: '2-2'

      click_on '更新する'

      expect(page).to have_content '配送先住所を更新しました'
      expect(page).to have_current_path users_shipping_address_path

      shipping_address = ShippingAddress.last
      expect(shipping_address).to have_attributes(last_name: '鈴木', first_name: '次郎', tel: '09087654321',
                                                  post_code: '9000002', city: '渋谷区', other_address: '2-2')
    end
  end

  describe 'ヘッダー' do
    context 'ログインしている場合' do
      before { sign_in yamada, scope: :user }

      it 'ヘッダーに配送先住所のリンクが表示される' do
        visit root_path

        expect(page).to have_link '配送先住所', href: users_shipping_address_path
      end
    end

    context 'ログインしていない場合' do
      it 'ヘッダーに配送先住所のリンクが表示されない' do
        visit root_path

        expect(page).to have_content 'ログイン'
        expect(page).not_to have_link '配送先住所', href: users_shipping_address_path
      end
    end
  end
end
