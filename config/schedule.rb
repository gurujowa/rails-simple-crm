env :PATH, "/var/www/rails-crm/current/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
set :output, "/home/yamashita/whenever.log"

every 1.day, :at => '8:00 am' do
  rake "attend:teacher['development']"
end


every 1.day, :at => '11:59 am' do
  rake "attend:alert"
end

every 1.day, :at => '5:00 pm' do
  command %Q{backup perform --trigger crm_s3}
end
