json.draw 1
json.recordsTotal 1000
json.recordsFiltered 100
json.data do |json|
  json.array!(@leads) do |lead|
    json.extract! lead, :name, :tel, :full_address, :last_approach_day
  end
end
