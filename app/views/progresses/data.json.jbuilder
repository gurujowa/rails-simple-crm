json.array! (@courses) do |c|
  json.id c.id
  json.name(c.name)
  json.company c.company.name
  json.responsible c.responsible
  json.memo c.memo
  json.periods c.periods do |p|
    json.day p.day
  end
end
