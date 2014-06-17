json.array!(@leads) do |lead|
  json.extract! lead, :name, :tel, :fax, :email, :person_name, :person_kana, :person_post, :url, :zip_code, :prefecture, :street, :building, :memo, :user_id, :star
  json.url lead_url(lead, format: :json)
end
