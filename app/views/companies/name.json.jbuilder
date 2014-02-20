json.companies @companies do |c|
 json.text c.client_name + "(" + c.active_st_text + ")"
 json.id c.id
end

