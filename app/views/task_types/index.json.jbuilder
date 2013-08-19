json.array!(@task_types) do |task_type|
  json.extract! task_type, :name, :default_due, :default_assignee, :group
  json.url task_type_url(task_type, format: :json)
end
