json.array!(@billing_plans) do |billing_plan|
  json.extract! billing_plan, :name, :company_id, :tax_rate, :status
  json.url billing_plan_url(billing_plan, format: :json)
end
