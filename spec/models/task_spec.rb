require 'rails_helper'

RSpec.describe 'scope検索', type: :model do
  context 'scopeメソッドで検索をした場合' do
    before do
      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
    end
    it "scopeメソッドでタイトル検索ができる" do
      expect(Task.name_search('タスク1').count).to eq 1
    end
    it "scopeメソッドでステータス検索ができる" do
      expect(Task.status_search('完了').count).to eq 2
    end
    it "scopeメソッドでタイトルとステータスの両方が検索できる" do
      expect(Task.name_search('タスク1').status_search('完了').count).to eq 1
    end
  end
end

RSpec.describe 'タスク管理機能', type: :model do
  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(name: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end
  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(content: '失敗テスト', content: '')
    expect(task).not_to be_valid
  end
  it 'titleとcontentに内容が記載されていればバリデーションが通る' do
    task = Task.new(name: '成功テスト' , content: '成功テスト2')
    expect(task).to be_valid
  end
end