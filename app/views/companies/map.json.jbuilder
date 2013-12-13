json.companies @companies do |c|
 json.lat c.latitude
 json.lng c.longitude
 json.name c.client_name
 json.client_person c.client_person
 json.address c.full_address
 json.contents %Q{会社名=#{ c.name} <br>担当者名=#{c.client_person} <br>住所=#{c.full_address} <br>電話番号=#{c.tel}<br>URL = <a href="/companies/#{c.id}/edit" target="__blank">URLはこちら</a>}
end
