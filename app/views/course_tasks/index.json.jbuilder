json.array! @tasks do |j2, t|
  j2.course_task_id t.id
  j2.title t.title + "(" + t.course.lead.name + ")"
  j2.title_text t.title
  j2.allDay t.all_day
  j2.url url_for(controller: "courses", action: "show", id: t.course.id)
  j2.start t.start.iso8601
  j2.end t.end.iso8601 if t.end.present?
  j2.memo t.memo
  j2.course_id t.course_id
end
