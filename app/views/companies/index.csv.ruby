require 'csv'
c = CSV.generate do |csv|
  csv << Company.column_names + ["client_name"]
  Company.all.each do |model|
    values = model.attributes.values_at(*Company.column_names)
    values << model.clients.first.name
    csv << values
  end
end
c.encode("Shift_JIS",invalid: :replace, undef: :replace)
