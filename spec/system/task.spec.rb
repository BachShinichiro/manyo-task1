require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, name: '1つ目登録名前', content: '1つ目登録内容') }
  let!(:task1) { FactoryBot.create(:task, name: '2つ目登録名前', content: '2つ目登録内容') }
  before do
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in :task_name, with: 'TaskName'
        fill_in :task_content, with: 'TaskContent'
        click_button "登録する"
        expect(page).to have_content 'TaskName'
        expect(page).to have_content 'TaskContent'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content '1つ目登録名前'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '2つ目登録名前'
        expect(task_list[1]).to have_content '1つ目登録名前'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, name: 'task')
         visit task_path(task.id)
         expect(page).to have_content 'task'
       end
     end
  end
end
