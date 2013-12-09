# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

every 1.day, :at => '6:00 pm' do
  rake "mail:contact"
  rake "mail:alert"
end

every 1.day, :at => '6:00 am' do
  rake "mail:course:end"
  rake "mail:course:reminder"
  command %Q{backup perform --trigger crm_backup}
  command %Q{backup perform --trigger crm_dropbox}
end

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
