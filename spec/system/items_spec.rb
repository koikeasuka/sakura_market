require 'rails_helper'

RSpec.describe '商品画面', type: :system do
  describe '一覧' do
    before do
      create(:item, name: 'みかん', price: 500)
      create(:item, name: 'トマト', price: 300)
    end

    it '商品が表示されること' do
      visit root_path

      expect(page).to have_content 'みかん'
      expect(page).to have_content '500円'
      expect(page).to have_content 'トマト'
      expect(page).to have_content '300円'
    end
  end
end
