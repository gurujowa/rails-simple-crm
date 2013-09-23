json.companies @companies do |c|
 json.text c.client_name + " - " + c.status.rank+ "(" + c.status.name + ")"
 json.id c.id
end

