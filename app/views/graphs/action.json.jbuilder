json.array! @contacts do |c|
 json.created c.created_at.strftime("%Y-%m")
 json.type c.type.name
 json.sales_person get_user_name(c.sales_person)
end

