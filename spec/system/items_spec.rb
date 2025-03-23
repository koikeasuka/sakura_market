require 'rails_helper'

RSpec.describe '商品画面', type: :system do
  describe '一覧' do
    before do
      create(:item, name: 'みかん', price: 500, is_published: true, position: 1)
      create(:item, name: 'レモン', price: 400, is_published: true, position: 2)
      create(:item, name: 'トマト', price: 300, is_published: false, position: 3)
    end

    it '順番通りに商品が表示され、非表示の商品は見えない' do
      visit root_path

      within first('.item-card') do
        expect(page).to have_content 'みかん'
        expect(page).to have_content '500円'
      end

      within all('.item-card')[1] do
        expect(page).to have_content 'レモン'
        expect(page).to have_content '400円'
      end

      expect(page).not_to have_content 'トマト'
      expect(page).not_to have_content '300円'
    end
  end

  describe '詳細' do
    let(:item) { create(:item, name: 'さば', price: 200, description: '三陸海岸から直送で届いたサバをで缶詰にしました') }

    it '商品の詳細が表示されること' do
      visit item_path(item)

      expect(page).to have_content 'さば'
      expect(page).to have_content '200円'
      expect(page).to have_content '三陸海岸から直送で届いたサバをで缶詰にしました'
    end
  end
end
