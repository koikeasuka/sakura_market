require 'rails_helper'

RSpec.describe '管理画面ログイン・ログアウト', type: :system do
  let(:yamada) { create(:admin) }

  context '管理画面ログインしている場合' do
    before { sign_in yamada, scope: :admin }

    it 'ログアウトできる' do
      visit admins_root_path

      click_on 'ログアウト'
      expect(page).to have_content 'ログアウトしました'
    end
  end
end
