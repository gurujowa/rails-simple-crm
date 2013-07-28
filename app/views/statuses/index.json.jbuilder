json.array!(@statuses) do |status|
  json.extract! status, :name, :rank, :active
  json.url status_url(status, format: :json)
end
