json.extract! task, :id, :name, :content, :end_date, :priority, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
