json.array! @periods do |j2, p|
  j2.title "#{p.course.lead.corp_name}【#{p.number}/#{p.total_number}】(#{p.teacher.name})"
  j2.start p.start_date.iso8601
  j2.end p.end_date.iso8601
  j2.url "/courses/" + p.course.id.to_s + "/edit"
  j2.number p.number
  j2.total_number p.total_number
end
