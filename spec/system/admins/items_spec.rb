require 'rails_helper'

RSpec.describe '商品画面', type: :system do
  let(:yamada) { create(:admin) }

  describe '一覧' do
    before do
      create(:item, name: 'みかん', description: '甘いみかんです', price: 500, position: 1, is_published: true)
      create(:item, name: 'トマト', description: '太陽のトマトです', price: 300, position: 2, is_published: false)
    end

    it '商品が表示されること' do
      sign_in yamada, scope: :admin

      visit admins_items_path

      expect(page).to have_content 'みかん'
      expect(page).to have_content '甘いみかんです'
      expect(page).to have_content '500円'
      expect(page).to have_content '公開中'
      expect(page).to have_content 'トマト'
      expect(page).to have_content '太陽のトマトです'
      expect(page).to have_content '300円'
      expect(page).to have_content '非公開'
    end

    it 'ページの順番を入れ替えることができる', :js do
      sign_in yamada, scope: :admin

      visit admins_items_path

      # ドラッグ&ドロップで順番を入れ替える
      find('tbody').first('tr').drag_to find('tbody').all('tr')[1]

      # 順番が入れ替わっていることを確認
      expect(find('tbody').first('tr')).to have_content 'トマト'
      expect(find('tbody').all('tr')[1]).to have_content 'みかん'
    end
  end

  describe '新規登録' do
    before { sign_in yamada, scope: :admin }

    it '新規登録ができること', :js do
      visit new_admins_item_path

      attach_file '商品画像', Rails.root.join('spec/fixtures/items/hakusai.png')
      fill_in '商品名', with: '白菜'
      fill_in '商品説明', with: 'シャキシャキの白菜です'
      fill_in '価格', with: 200
      check '公開状態'

      click_on '登録する'

      expect do
        expect(page).to have_content '商品の登録が完了しました'

        item = Item.last
        # 登録後、詳細画面に遷移することを確認
        expect(page).to have_current_path admins_items_path
        expect(item.product_photo.blob.filename).to eq 'hakusai.png'
        expect(item).to have_attributes(name: '白菜', description: 'シャキシャキの白菜です', price: 200, is_published: true)
      end.to change(Item, :count).by(1)
    end
  end

  describe '詳細' do
    before { sign_in yamada, scope: :admin }

    let(:item) { create(:item, name: 'メロン', description: '種の少ないメロン', price: 1500, position: 1, is_published: false) }

    it '詳細画面が表示される' do
      visit admins_item_path(item)

      expect(page).to have_content '商品詳細'
      expect(page).to have_content 'メロン'
      expect(page).to have_content '種の少ないメロン'
      expect(page).to have_content '1,500円'
      expect(page).to have_content '表示順 1'
      expect(page).to have_content '非公開'
    end

    it '削除できる', :js do
      visit admins_item_path(item)

      click_on '削除'

      expect do
        page.accept_confirm '削除してもよろしいですか'
        expect(page).to have_content '商品を削除しました'
        expect(page).to have_current_path admins_items_path
      end.to change(Item, :count).by(-1)
    end
  end

  describe '編集' do
    before { sign_in yamada, scope: :admin }

    let(:item) { create(:item, name: 'スイカ', description: '種の少ないスイカです', price: 1200, is_published: true) }

    it '編集ができること' do
      visit edit_admins_item_path(item)
      expect(page).to have_content '商品編集'

      attach_file '商品画像', Rails.root.join('spec/fixtures/items/suika.png')
      fill_in '商品名', with: '太陽のスイカ'
      fill_in '商品説明', with: '太陽をたくさん吸収した、種の少ない太陽のスイカです'
      fill_in '価格', with: 1500
      uncheck '公開状態'

      click_on '更新する'

      expect(page).to have_content '商品情報を更新しました'
      item.reload
      expect(item.product_photo.blob.filename).to eq 'suika.png'
      expect(item).to have_attributes(name: '太陽のスイカ', description: '太陽をたくさん吸収した、種の少ない太陽のスイカです', price: 1500, is_published: false)
    end
  end
end
