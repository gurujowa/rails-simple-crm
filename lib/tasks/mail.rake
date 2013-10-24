namespace :mail do
  desc "メール送信"
  task :contact  => :environment do |task, args|
      puts "contact send start"
      beginning =  DateTime.now.beginning_of_day.utc.to_s(:db)
      contacts = Contact.where("STRFTIME('%Y-%m-%d %H:%M:%S', created_at) > ?", beginning).all
      
      puts beginning
      if (contacts.present?)         
        ContactMailer.today(contacts).deliver
      end
  end


  task :course_end => :environment do |task, args|
      puts "コース終了時のメール開始"

      courses = Course.all
      ended_courses = []
      courses.each do |c|
        if c.end_date == Date.today
          ended_courses.push c
        end
      end

      if ended_courses.length != 0
        AlertMailer.end(ended_courses).deliver
      end
  end

  task :alert => :environment do |task, args|
      puts "アラートのメール開始"

      alerts = Alert.check

      if alerts.length != 0
        AlertMailer.course(alerts).deliver
      end
  end
end
