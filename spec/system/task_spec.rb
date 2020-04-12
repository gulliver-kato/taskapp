require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される'do
        visit tasks_path
        expect(page).to have_content 'タスク1'
      end
    end

    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいる' do
        visit tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'タスク2'
        expect(task_list[1]).to have_content 'タスク1'
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        fill_in 'task_name', with: 'タスク1'
        fill_in 'task_content', with: 'コンテンツ1'
        fill_in 'task_priority', with: '1'
        fill_in 'task_status', with: '1'
        click_on 'commit'
        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'コンテンツ1'
      end
    end
  end
  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移する' do
        task = FactoryBot.create(:task)
        visit task_path(task.id)
        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'コンテンツ1'
      end
    end  
  end
end
