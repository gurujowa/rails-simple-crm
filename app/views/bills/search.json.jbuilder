json.companies @line do |c|
 json.text c.billing_plan.company.client_name + " - 請求日:" + c.bill_date.to_s(:db)
 json.id c.id
end

