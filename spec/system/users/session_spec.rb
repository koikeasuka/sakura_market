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

    it 'ヘッダーに会員設定のリンクが表示される' do
      visit root_path

      expect(page).to have_link '会員設定', href: edit_user_registration_path
    end
  end
end
