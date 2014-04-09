Time::DATE_FORMATS[:default] = '%Y/%m/%d %H:%M'
Time::DATE_FORMATS[:datetime] = '%Y/%m/%d %H:%M'
Time::DATE_FORMATS[:date] = '%Y/%m/%d'
Time::DATE_FORMATS[:time] = '%H:%M'
Date::DATE_FORMATS[:default] = '%Y/%m/%d'
Time::DATE_FORMATS.merge!(
  :jp => lambda { |t| t.strftime("%Y年%m月%d日(#{%w(日 月 火 水 木 金 土)[t.wday]})") },
)

Date::DATE_FORMATS.merge!(
  :jp => lambda { |t| t.strftime("%Y年%m月%d日(#{%w(日 月 火 水 木 金 土)[t.wday]})") },
)
