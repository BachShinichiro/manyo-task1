require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:label) { FactoryBot.create(:label) }
  let!(:label2) { FactoryBot.create(:label2) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:second_task) { FactoryBot.create(:task, name: 'second_task', user: user) }

  before do
  visit new_session_path
  fill_in "Email", with: 'admin@admin.com'
  fill_in "Password", with: 'password'
  click_button "Log in"
  visit tasks_path
  end


  describe 'ラベル機能のテスト' do
    context 'タスクを新規作成した場合' do
      it 'タスクと一緒にラベルを登録できる' do
        visit new_task_path
        fill_in :task_name, with: 'TaskName'
        fill_in :task_content, with: 'TaskContent'
        select '完了', from: :task_status
        select '高', from: :task_priority
        check 'ラベル1'
        click_button "登録する"
        expect(page).to have_content('ラベル1')
      end
      it 'タスクの編集と一緒にラベルを編集できる' do
        visit tasks_path
        click_on "編集", match: :first
        fill_in :task_name, with: 'TaskName'
        fill_in :task_content, with: 'TaskContent'
        select '完了', from: :task_status
        select '高', from: :task_priority
        check 'ラベル2'
        click_button "更新する"
        expect(page).to have_content('ラベル2')
      end
      it 'タスクの詳細画面で、そのタスクに紐づいているラベル一覧を出力する' do
        visit new_task_path
        fill_in :task_name, with: 'TaskName'
        fill_in :task_content, with: 'TaskContent'
        select '完了', from: :task_status
        select '高', from: :task_priority
        check 'ラベル1'
        click_button "登録する"
        visit tasks_path
        click_on "詳細", match: :first
        expect(page).to have_content('ラベル1')
      end
    end
  end

  describe 'ラベル検索機能' do
    context '一覧画面に遷移した場合' do
      it 'つけたラベルで検索できる' do
        visit new_task_path
        fill_in :task_name, with: 'TaskName'
        fill_in :task_content, with: 'TaskContent'
        select '完了', from: :task_status
        select '高', from: :task_priority
        check 'ラベル1'
        click_button "登録する"
        visit new_task_path
        fill_in :task_name, with: 'TaskName'
        fill_in :task_content, with: 'TaskContent'
        select '完了', from: :task_status
        select '高', from: :task_priority
        check 'ラベル2'
        click_button "登録する"
        visit tasks_path
        select 'ラベル1', from: :label_id
        click_on '登録'
        expect(page).to have_content 'ラベル1'
      end
    end
  end
end
