json.array!(@tasks) do |task|
  json.extract! task, :type, :duedate, :name, :assignee, :created_by, :note
  json.url task_url(task, format: :json)
end
