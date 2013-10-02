require 'rubygems'
require 'google_calendar'

namespace :calendar do
  desc "コースカレンダー更新"
  task :google  => :environment do |task, args|
      puts "コースカレンダー登録開始"

      cal = CrmApi::Calendar.instance
      periods = Period.where(google_id: nil).all
      periods.each do |p|
        event = cal.create_event do |e|
            e.title = %Q{#{p.course.company.client_name}【#{p.teacher.name}】}
            e.content = %Q{講師=#{p.teacher.name} \n コース名=#{p.course.name} \n }
            e.start_time = p.start_time
            e.end_time = p.end_time
        end
        p.update_attributes(:google_id => event.id)
        puts event
      end

      puts "コースカレンダー 終了"
  end
end
