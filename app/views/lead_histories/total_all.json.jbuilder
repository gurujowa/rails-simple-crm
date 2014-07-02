json.array! @lead_histories do |c|
 json.user_name c.user.name
 json.day c.approach_day.day
 json.month c.approach_day.month.to_s + "月"
 json.year c.approach_day.year.to_s + "年"
 json.status c.lead_history_status.name
end

