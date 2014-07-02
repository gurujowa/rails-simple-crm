json.array! @lead_histories do |c|
 json.day c.approach_day.day
 json.status c.lead_history_status.name
end

