json.array!(@teacher_orders) do |teacher_order|
  json.extract! teacher_order, :teacher_id, :unit_price, :memo, :invoice_flg, :payment_flg, :payment_term, :memo, :order_date, :payment_date
  json.url teacher_order_url(teacher_order, format: :json)
end
