json.companies @companies do |c|
 json.lat c.latitude
 json.lng c.longitude
 json.name c.name
 json.address c.full_address
end
