# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { 'タスク1' }
    content { 'コンテンツ1' }
    end_date { '2020-05-01' }
    priority { '高' }
    status { '完了' }
    # Label { 'label1' }
    user
  end
  factory :second_task, class: Task do
    name { 'タスク2' }
    content { 'コンテンツ2' }
    end_date { '2020-05-02' }
    priority { '中' }
    status { '完了' }
    # Label { 'label2' }
    user
  end
end
