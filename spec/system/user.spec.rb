require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  before do
    @second_user = FactoryBot.create(:second_user)
    @user = FactoryBot.create(:user)
  end

  # describe '新規作成機能' do
  #   context 'ユーザを新規作成した場合' do
  #     it '作成したユーザが表示される' do
  #       visit new_user_path
  #       fill_in "ユーザー名", with: 'bach'
  #       fill_in "メールアドレス", with: 'bach@bach.com'
  #       fill_in "パスワード", with: 'bachbach'
  #       fill_in "確認用パスワード", with: 'bachbach'
  #       click_button "アカウント登録"
  #       expect(page).to have_content 'bach@bach.com'
  #     end
  #   end
  #   context 'ユーザがログインせずタスク一覧に飛ぼうとした場合' do
  #     it 'ログイン画面に遷移する' do
  #       visit tasks_path
  #       expect(page).to have_content 'ログイン'
  #     end
  #   end
  # end

  # describe 'セッション機能' do
  #   context 'ログインしようとすると' do
  #     before do 
  #       visit new_session_path
  #       fill_in "Email", with: 'picasso@picasso.com'
  #       fill_in "Password", with: 'picassopicasso0123'
  #       click_button "Log in"
  #     end
  #     it 'ログインができること' do
  #       expect(page).to have_content 'picasso@picasso.com'
  #     end
  #     it '自分の詳細画面(マイページ)に飛べること' do
  #       expect(page).to have_content 'picasso'
  #     end
  #     it "一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること" do
  #       visit user_path(@user.id)
  #       expect(page).to have_content "タスク一覧"
  #     end
  #     it "ログアウトができること" do
  #       visit user_path(id: @user.id)
  #       click_on ('ログアウト')
  #       expect(page).to have_content "ログアウトしました"
  #     end	
  #   end
  # end

  describe "管理画面のテスト" do
    context "管理者がログインしている場合" do
      it "管理者は管理画面にアクセスできること" do
        visit new_session_path
        fill_in "Email", with: "admin@admin.com"
        fill_in "Password", with: "password"
        click_on ('Log in')
        visit admin_users_path
        expect(page).to have_content "ユーザー一覧"
      end
      it "一般ユーザは管理画面にアクセスできないこと" do
        visit new_session_path
        fill_in "Email", with: 'picasso@picasso.com'
        fill_in "Password", with: 'picassopicasso0123'
        click_button "Log in"
        visit admin_users_path
        expect(page).to have_content "管理者以外はアクセスできません"
      end
      it "管理者はユーザを新規登録できること" do
        visit new_session_path
        fill_in "Email", with: 'admin@admin.com'
        fill_in "Password", with: 'password'
        click_button "Log in"
        visit admin_users_path
        click_on ('new')
        fill_in "name", with: 'shaka'
        fill_in "Email address", with: 'shaka@shaka.com'
        fill_in "Password", with: 'shakashaka'
        fill_in "Password_confirmation", with: 'shakashaka'
        click_button "Create"
        expect(page).to have_content "shaka"
      end
      it '管理ユーザはユーザの詳細画面にアクセスできること' do
        visit new_session_path
        fill_in "Email", with: 'admin@admin.com'
        fill_in "Password", with: 'password'
        click_button "Log in"
        visit admin_users_path(id: @user.id)
        expect(page).to have_content "admin@admin.com"
      end
      it '管理ユーザはユーザの編集画面からユーザを編集できること' do
        visit new_session_path
        fill_in "Email", with: 'admin@admin.com'
        fill_in "Password", with: 'password'
        click_button "Log in"
        visit edit_admin_user_path(id: @user.id)
        fill_in 'name', with: 'edit'
        fill_in 'Email address', with: 'edit@power.com'
        fill_in 'Password', with: 'editdit'
        fill_in 'Password_confirmation', with: 'editdit'
        click_on 'Create'
        expect(page).to have_content "edit"
      end
      it '管理者はユーザの削除をできること' do
        visit new_session_path
        fill_in "Email", with: 'admin@admin.com'
        fill_in "Password", with: 'password'
        click_button "Log in"
        visit admin_users_path
        click_on "delete", match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "削除しました"
      end
    end
  end
end