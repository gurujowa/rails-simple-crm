json.array! @lead_histories do |c|
 json.day c.approach_day.day
 json.status c.lead_history_status.name
 json.progress c.lead_history_status.progress_text
 json.week c.approach_day.strftime("%W").to_s + "週"
end

