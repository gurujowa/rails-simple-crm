BusinessTime::Config.load("#{Rails.root}/config/business_time.yml")

HolidayJp.between(Date.new(2016, 1, 1), 2.years.from_now).map do |holiday|
  BusinessTime::Config.holidays << holiday.date
end
