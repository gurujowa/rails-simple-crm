env :PATH, "/var/www/rails-crm/current/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
set :output, "/home/yamashita/whenever.log"

every 1.day, :at => '6:00 pm' do
  rake "mail:contact"
  rake "mail:alert"
end

every 1.day, :at => '5:00 pm' do
  command %Q{backup perform --trigger crm_backup}
  command %Q{backup perform --trigger crm_dropbox}
end

every 1.day, :at => '6:00 am' do
  rake "mail:course:end"
  rake "mail:course:reminder"
end

every :month do
  rake "mail:bill"
end
