json.array!(@clients) do |client|
  json.extract! client, :last_name, :first_name, :last_kana, :first_kana, :tel, :fax, :email, :gender, :official_position, :company_id, :memo
  json.url client_url(client, format: :json)
end
