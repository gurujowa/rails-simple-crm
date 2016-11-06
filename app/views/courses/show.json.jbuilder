json.extract! @course, :id, :name, :students, :total_time, :memo, :periods
json.lead_name @course.lead.name
json.lead_zipcode @course.lead.zipcode
json.lead_address @course.lead.full_address
json.periods @course.periods do |p|
    json.day "#{p.day.to_s(:jp)} #{p.start_time.to_s(:time)}～#{p.end_time.to_s(:time)} (合計時間#{p.total_time_format})"
    json.break_time "(休憩：#{p.break_start&.to_s(:time)}～#{p.break_end&.to_s(:time)})"
    json.break_flg  p.break_start.present? && p.break_end.present?
    json.teacher p.teacher.name
end
json.course_addresses @course.course_addresses do |a|
  json.extract! a, :name, :address, :station, :responsible, :tel, :projector_text, :board_text, :memo
end
