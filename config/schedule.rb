env :PATH, "/var/www/rails-crm/current/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
set :output, "/home/yamashita/whenever.log"

every :month do
  rake "attend:monthly"
end

every :weekday, :at => '8:00 am' do
  rake "attend:today[go]"
end

every :weekday, :at => '13:00 pm' do
  rake "attend:tomorrow[go]"
  rake "attend:holiday[go]"
end

every :weekday, :at => '11:59 am' do
  rake "attend:alert[today]"
end

every :weekday, :at => '5:00 pm' do
  rake "attend:alert[tomorrow]"
end

every 1.day, :at => '6:00 pm' do
  command %Q{backup perform --trigger crm_s3}
end
