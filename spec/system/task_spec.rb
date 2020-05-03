# frozen_string_literal: true

require 'rails_helper'
require 'selenium-webdriver'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @user = create(:user)
    @admin_user = create(:admin_user)

    @label1 = create(:label1)
    @label2 = create(:label2)
    create(:task, user: @user)
    create(:second_task, user: @user)

    visit new_session_path
    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.password
    click_button 'log in'
  end

  describe 'ラベル管理について' do
    context 'ラベル登録がされていない場合' do
      it 'タスクにラベルを登録する' do
        visit new_task_path
        fill_in 'task_name', with: 'タスク1'
        fill_in 'task_content', with: 'コンテンツ1'
        select '高', from: 'task_priority'
        select '完了', from: 'task_status'
        check 'label1'
        click_on 'commit'
        expect(page).to have_content 'label1'
      end
      it 'タスクに複数ラベルを登録する' do
        visit new_task_path
        fill_in 'task_name', with: 'タスク1'
        fill_in 'task_content', with: 'コンテンツ1'
        select '高', from: 'task_priority'
        select '完了', from: 'task_status'
        check 'label1'
        check 'label2'
        click_on 'commit'
        expect(page).to have_content 'label1'
        expect(page).to have_content 'label2'
      end
    end
    context `タスク一覧がソートされていない場合` do
      it 'ラベルでタスクが検索できる' do
          visit tasks_path
          select 'label1', from: 'label_id'
          click_button '検索'
          expect(page).to have_content 'label1'
      end
    end
  end
  describe '優先順位での並び変え' do
    context '優先順位でソートするをクリックした場合' do
      it '優先順位が高い順に並んでいる' do
        visit tasks_path
        click_on '優先順位でソートする'
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        sleep 0.5 # テスト失敗を回避
        task_list = all('.priority_high')
        expect(task_list[0]).to have_content '高'
        expect(task_list[1]).to have_content '中'
      end
    end
  end

  describe '検索機能' do
    context 'タイトルで検索をした場合' do
      it 'タイトルで検索ができる' do
        visit tasks_path
        fill_in 'name', with: 'タスク1'
        click_button 'Search'
        expect(page).to have_content 'タスク1'
      end
    end

    context 'ステータスで検索をした場合' do
      it 'ステータスで検索ができる' do
        visit tasks_path
        select '完了', from: 'status'
        click_button 'Search'
        expect(page).to have_content '完了'
      end
    end

    context 'タイトルとステータスで検索をした場合' do
      it 'タイトルとステータスで検索ができる' do
        visit tasks_path
        fill_in 'name', with: 'タスク1'
        select '完了', from: 'status'
        click_button 'Search'
        expect(page).to have_content 'タスク1'
        expect(page).to have_content '完了'
      end
    end
  end

  describe '終了期限での並び変え' do
    context '終了期日を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_task_path
        # fill_in 'end_date', with: '2020,5,1'
        # save_and_open_page
        select '2020', from: 'task_end_date_1i'
        select '5', from: 'task_end_date_2i'
        select '1', from: 'task_end_date_3i'
        click_on 'commit'
        expect(page).to have_content '2020'
        expect(page).to have_content '5'
        expect(page).to have_content '1'
      end
    end

    context '終了期限でソートするをクリックした場合場合' do
      it 'タスクが終了期限の降順に並んでいる' do
        visit tasks_path
        click_on '終了期限でソートする'
        sleep 0.5 # テスト失敗を回避
        task_list = all('.date_row')
        expect(task_list[0]).to have_content '2020-05-02'
        expect(task_list[1]).to have_content '2020-05-01'
      end
    end
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示される' do
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
        select '高', from: 'task_priority'
        select '完了', from: 'task_status'
        click_on 'commit'
        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'コンテンツ1'
      end
    end
  end
  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移する' do
        task = FactoryBot.create(:task, user: @user)
        visit task_path(task.id)
        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'コンテンツ1'
      end
    end
  end
end
