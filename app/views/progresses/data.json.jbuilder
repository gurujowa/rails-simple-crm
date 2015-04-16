json.array! (@courses) do |c|
  json.id c.id
  json.name(c.name)
  json.company c.company.name
  json.responsible c.responsible
  json.memo c.memo
  json.periods c.periods do |p|
    json.day p.day
    json.teacher p.teacher.name
    json.start_time p.start_time
    json.end_time p.end_time
  end
end
