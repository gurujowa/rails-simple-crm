env :PATH, "/var/www/rails-crm/current/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
set :output, "/home/yamashita/whenever.log"

every 1.day, :at => '7:30 pm' do
  rake "mail:contact"
  rake "backup:dropbox"
end

every 1.day, :at => '5:00 pm' do
  command %Q{backup perform --trigger crm_s3}
end

every 1.day, :at => '12:10 pm' do
  rake "mail:course:end"
  rake "mail:course:reminder"
end

every :month do
  rake "mail:bill"
end
