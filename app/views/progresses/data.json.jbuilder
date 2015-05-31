json.array! (@courses) do |c|
  json.id c.id
  json.name(c.name)
  json.company c.company.name
  json.responsible c.responsible
  json.memo c.memo
  json.periods c.periods do |p|
    json.day p.day.to_s(:date)
    json.teacher p.teacher.id
    json.start_time p.start_time.to_s(:time)
    json.end_time p.end_time.to_s(:time)
  end
end
