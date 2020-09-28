require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, name: '1つ目登録タスク', content: '1つ目登録内容') }
  let!(:task1) { FactoryBot.create(:task, name: '2つ目登録タスク', content: '2つ目登録内容') }
  before do
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in :task_name, with: 'TaskName'
        fill_in :task_content, with: 'TaskContent'
        select '完了', from: :task_status
        select '高', from: :task_priority
        click_button "登録する"
        expect(page).to have_content 'TaskName'
        expect(page).to have_content 'TaskContent'
        expect(page).to have_content '完了'
        expect(page).to have_content '高'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content '1つ目登録タスク'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '2つ目登録タスク'
        expect(task_list[1]).to have_content '1つ目登録タスク'
      end
    end
    context '終了期限でソートするボタンを押した場合' do
      it '終了期限の降順にソートされ表示される' do
        tomorrow = Date.today + 1
        task = FactoryBot.create(:task, name: '１つ目登録名前', content: '１つ目登録内容', limit: tomorrow)
        task = FactoryBot.create(:task, name: '２つ目登録名前', content: '２つ目登録内容')
        visit tasks_path
        click_on '終了期限でソートする'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content Date.today + 1
        expect(task_list[1]).to have_content Date.today
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
  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in :name, with: '1つ目登録タスク'
        click_button '登録'
        expect(page).to have_content '1つ目登録タスク'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '未着手', from: :status
        click_on '登録'
        expect(page).to have_content '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in :name, with: 'タスク'
        select '着手中', from: :status
        click_button '登録'
        expect(page).to have_content '着手中'
        expect(page).to have_content 'タスク'
      end
    end
  end
end
