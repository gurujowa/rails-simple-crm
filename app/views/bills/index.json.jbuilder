json.array!(@bills) do |bill|
  json.extract! bill, :name, :duedate, :billing_plan_line_id, :bill_flg, :payment_flg, :memo
  json.url bill_url(bill, format: :json)
end
