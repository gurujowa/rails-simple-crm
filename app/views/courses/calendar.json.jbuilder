json.eventSources @courses do |j, c|
  j.color c.color
  j.textColor c.text_color
  j.allDayDefault false
  
  json.events c.periods do |j2, p|
    j2.title c.lead.name + "(" + p.teacher.name + ")"
    j2.start p.day.to_s + " " + p.start_date.strftime("%H:%M:%S")
    j2.end p.day.to_s + " " + p.end_date.strftime("%H:%M:%S")
    j2.url "/courses/" + c.id.to_s + "/edit"
  end

end
