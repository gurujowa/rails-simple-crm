json.array! (@periods) do |c|
  json.id c.id
  json.day(c.day.to_s(:date))
  json.teacher(c.teacher.id)
  json.start_time(c.start_time.to_s(:time))
  json.end_time(c.end_time.to_s(:time))
  json.break_start c.break_start
  json.break_end c.break_end
  json.memo(c.memo)
end
