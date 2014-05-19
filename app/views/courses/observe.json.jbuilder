json.eventSources @courses do |j, c|
  j.textColor "white"
  j.allDayDefault false
  json.events c.periods.select{|e| e.user.present?} do |j2, p|
      j2.title c.company.client_name + "(" + p.user.name + ")"
      j2.color p.observe_color
      j2.start p.day.to_s + " " + p.start_time.strftime("%H:%M:%S")
      j2.end p.day.to_s + " " + p.end_time.strftime("%H:%M:%S")
      j2.url "/courses/" + c.id.to_s + "/edit"
  end

end
