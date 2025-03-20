require 'rails_helper'

RSpec.describe '会員情報画面', type: :system do
  let(:suzuki) { create(:admin) }

  before { sign_in suzuki, scope: :admin }

  describe '一覧' do
    before do
      create(:user, email: 'sato@example.com', updated_at: '2025-01-02 00:00:00')
      create(:user, email: 'yamada@example.com', updated_at: '2025-01-01 00:00:00')
    end

    it '会員情報が表示される' do
      visit admins_users_path

      expect(page).to have_content 'sato@example.com'
      expect(page).to have_content '2025/01/02 00:00'
      expect(page).to have_content 'yamada@example.com'
      expect(page).to have_content '2025/01/01 00:00'
    end
  end

  describe '詳細' do
    let(:yamada) { create(:user, email: 'yamada@example.com', updated_at: '2025-01-01 00:00:00') }

    it '削除できる' do
      visit admins_user_path(yamada)

      expect(page).to have_content 'yamada@example.com'
      expect do
        click_on '削除'

        expect(page).to have_content '会員情報を削除しました'
        expect(page).to have_current_path admins_users_path
      end.to change(User, :count).by(-1)
    end
  end

  describe '編集' do
    let(:yamada) { create(:user, email: 'yamada@example.com', updated_at: '2025-01-01 00:00:00') }

    it '編集ができる' do
      visit edit_admins_user_path(yamada)

      fill_in 'メールアドレス', with: 'sato@example.com'
      fill_in 'パスワード', with: 'passpass'
      fill_in 'パスワード（確認用）', with: 'passpass'

      click_on '更新する'

      expect(page).to have_content '会員情報を更新しました'
      expect(page).to have_current_path admins_user_path(yamada)
    end
  end
end
