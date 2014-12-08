json.array!(@public_bills) do |public_bill|
  json.extract! public_bill, :id, :name, :publish_date, :send_flg, :company_name, :invoice_date, :payment_date, :memo
  json.url public_bill_url(public_bill, format: :json)
end
