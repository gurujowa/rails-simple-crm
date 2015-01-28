json.array!(@estimates) do |estimate|
  json.extract! estimate, :title, :company_id, :expired, :tax_flg, :send_flg, :memo
  json.url estimate_url(estimate, format: :json)
end
