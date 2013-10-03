json.array!(@campaigns) do |campaign|
  json.extract! campaign, :name, :bill, :sent, :start_date, :memo
  json.url campaign_url(campaign, format: :json)
end
