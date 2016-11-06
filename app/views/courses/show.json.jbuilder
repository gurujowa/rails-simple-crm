json.extract! @course, :id, :name, :students, :total_time, :memo, :periods
json.lead_name @course.lead.name
json.lead_zipcode @course.lead.zipcode
json.lead_address @course.lead.full_address
json.periods @course.periods do |p|
    json.day p.datetime_fulltext
    json.teacher p.teacher.name
end
json.course_addresses @course.course_addresses do |a|
  json.extract! a, :name, :address, :station, :responsible, :tel, :projector_text, :board_text, :memo
end
