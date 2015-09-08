json.array! @periods do |j2, p|
  j2.title p.course.lead.name + "(" + p.teacher.name + ")"
  j2.start p.start_date.iso8601
  j2.end p.end_date.iso8601
  j2.url "/courses/" + p.course.id.to_s + "/edit"
end
