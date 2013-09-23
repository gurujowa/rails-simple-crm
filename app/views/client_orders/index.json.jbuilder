json.array!(@client_orders) do |client_order|
  json.extract! client_order, :company_id, :price, :invoice_flg, :payment_flg, :invoice_date, :payment_date, :memo
  json.url client_order_url(client_order, format: :json)
end
