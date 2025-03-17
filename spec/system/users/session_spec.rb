require 'rails_helper'

RSpec.describe '会員画面ログイン・ログアウト', type: :system do
  let(:suzuki) { create(:user) }

  context '会員画面ログインしている場合' do
    before { sign_in suzuki, scope: :user }

    it 'ログアウトできる' do
      visit root_path

      click_on 'ログアウト'
      expect(page).to have_content 'ログアウトしました'
    end
  end
end
