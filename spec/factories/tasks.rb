FactoryBot.define do
  factory :task do
    name { 'タスク1' }
    content { 'コンテンツ1' }
    end_date { '2020-05-01' }
    priority { '高' }
    status { '完了' }
  end
  factory :second_task, class: Task do
    name { 'タスク2' }
    content { 'コンテンツ2' }
    end_date { '2020-05-02' }
    priority { '高' }
    status { '完了' }
  end
end       
