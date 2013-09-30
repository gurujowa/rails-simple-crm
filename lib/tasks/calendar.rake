require 'rubygems'
require 'google_calendar'

namespace :calendar do
  desc "コースカレンダー更新"
  task :google  => :environment do |task, args|
      puts "コースカレンダー登録開始"
      yml = YAML::load(File.open("#{Rails.root.to_s}/shared/calendar.yml"))

      beginning =  DateTime.now.beginning_of_day.utc.to_s(:db)
      periods = Period.where(google_flg: false).all

      setting = {username: yml["username"], calendar: yml["calendar"], password: yml["password"], app_name: yml["app_name"]}
      
      cal = Google::Calendar.new(setting)
      periods.each do |p|
        event = cal.create_event do |e|
            e.title = %Q{#{p.course.company.client_name}【#{p.teacher.name}】}
            e.content = %Q{講師=#{p.teacher.name} \n コース名=#{p.course.name} \n }
            e.start_time = p.start_time
            e.end_time = p.end_time
        end
        puts event
      end

      Period.where(google_flg: false).update_all(google_flg: true)
      puts "コースカレンダー 終了"
  end
end
