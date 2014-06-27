json.array!(@lead_history_statuses) do |lead_history_status|
  json.extract! lead_history_status, :id, :name, :progress, :color
  json.url lead_history_status_url(lead_history_status, format: :json)
end
