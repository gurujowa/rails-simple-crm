json.array! @tasks do |j2, t|
  j2.task_id t.id
  j2.title t.name + "(" + t.lead.name + ")"
  j2.title_text t.name
  j2.allDay true
  j2.start t.due_date.iso8601
  j2.url url_for(controller: "leads", action: "show", id: t.lead.id)
  j2.memo t.memo
end
