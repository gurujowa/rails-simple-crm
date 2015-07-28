json.extract! @course, :id, :name, :address, :station, :responsible, :tel, :students, :total_time, :memo, :periods
json.lead_name @course.lead.name
json.lead_zipcode @course.lead.zipcode
json.lead_address @course.lead.full_address
json.periods @course.periods do |p|
    json.day p.day.to_s + " " + p.start_time.to_s(:time) + "～" + p.end_time.to_s(:time)
    json.teacher p.teacher.name
end
