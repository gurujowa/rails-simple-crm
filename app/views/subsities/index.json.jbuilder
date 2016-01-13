json.array!(@subsities) do |subsity|
  json.extract! subsity, :id, :name
  json.url subsity_url(subsity, format: :json)
end
