# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @admin_user = FactoryBot.create(:admin_user)
  end

  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'user[name]', with: 'test2'
        fill_in 'user[email]', with: 'test2@hotmail.com'
        fill_in 'user[password]', with: '222222'
        fill_in 'user[password_confirmation]', with: '222222'
        click_button 'Create my account'
        expect(page).to have_content 'test2'
        expect(page).to have_content 'test2@hotmail.com'
      end
      it 'ログインしていない時はログイン画面に飛ぶテスト' do
        visit root_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'セッション機能のテスト' do
    context 'ユーザのデータがなくログインしていない場合' do
      it 'セッションログインのテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'test1@hotmail.com'
        fill_in 'session[password]', with: '111111'
        click_button 'log in'
        # expect(page).to have_content 'test1'
        expect(page).to have_content 'test1@hotmail.com'
      end
      it '他人のマイページに飛ぶとタスク一覧ページに遷移するテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'test1@hotmail.com'
        fill_in 'session[password]', with: '111111'
        click_button 'log in'
        visit user_path(@admin_user.id)
        expect(current_path).to eq root_path
      end
    end
    context 'ユーザーがログインしている場合' do
      it 'セッションログアウトのテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'test1@hotmail.com'
        fill_in 'session[password]', with: '111111'
        click_button 'log in'
        click_link 'logout'
        expect(current_path).to eq new_session_path
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理画面のテスト' do
    context '管理者がいる状態' do
      it '管理者が管理画面にアクセスできるテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@hotmail.com'
        fill_in 'session[password]', with: '000000'
        click_button 'log in'
        visit admin_users_path
        expect(page).to have_selector 'h1', text: 'ユーザーリスト'
      end
      it '一般ユーザーが管理画面にアクセスできないテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'test1@hotmail.com'
        fill_in 'session[password]', with: '111111'
        click_button 'log in'
        visit admin_users_path
        expect(page).to have_selector 'h1', text: 'タスク一覧'
      end
      it '管理者がユーザーの新規登録ができるテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@hotmail.com'
        fill_in 'session[password]', with: '000000'
        click_button 'log in'
        visit new_admin_user_path
        fill_in 'user[name]', with: 'test3'
        fill_in 'user[email]', with: 'test3@hotmail.com'
        fill_in 'user[password]', with: '333333'
        fill_in 'user[password_confirmation]', with: '333333'
        click_button 'Create my account'
        expect(current_path).to eq admin_users_path
        expect(page).to have_selector 'h1', text: 'ユーザーリスト'
      end
      it '管理者がユーザーの詳細画面にアクセスできるテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@hotmail.com'
        fill_in 'session[password]', with: '000000'
        click_button 'log in'
        visit admin_user_path(@admin_user.id)
        expect(page).to have_content 'admin'
        expect(page).to have_content 'admin@hotmail.com'
      end
      it '管理者がユーザーの編集画面からユーザーを編集できるテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@hotmail.com'
        fill_in 'session[password]', with: '000000'
        click_button 'log in'
        visit edit_admin_user_path(@user.id)
        fill_in 'user[name]', with: 'test1'
        fill_in 'user[email]', with: 'test1@hotmail.com'
        fill_in 'user[password]', with: '111111'
        click_button 'Edit my account'
        expect(page).to have_content 'test1'
      end
      it '管理者がユーザーの削除ができるテスト' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@hotmail.com'
        fill_in 'session[password]', with: '000000'
        click_button 'log in'
        visit admin_users_path
        page.accept_confirm do
          click_on 'Destroy', match: :first
        end
        expect(page).to have_selector 'h1', text: 'ユーザーリスト'
      end
    end
  end
end
