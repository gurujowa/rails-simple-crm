namespace :mail do
  desc "本日のコンタクト内容のメール送信"
  task :contact  => :environment do
      puts "contact send start"
      beginning =  DateTime.now.beginning_of_day.utc.to_s(:db)
      contacts = Contact.joins(:company).where("STRFTIME('%Y-%m-%d %H:%M:%S', contacts.created_at) > ?", beginning).order("companies.sales_person").all
      
      if (contacts.present?)         
        ContactMailer.today(contacts).deliver
      end
  end

  desc "コースのリマインダーメール"
  task "course:reminder" => :environment do
      beginning =  DateTime.now.beginning_of_day.utc.to_s(:db)
      ending =  DateTime.tomorrow.end_of_day.utc.to_s(:db)
      periods = Period.where("STRFTIME('%Y-%m-%d %H:%M:%S', day) > ?", beginning).where("STRFTIME('%Y-%m-%d %H:%M:%S', day) <= ?",ending).all

      periods.each do |p|
        AlertMailer.reminder(p).deliver
      end
  end

  desc "売上表の送付"
  task "bill" => :environment do
    BillMailer.sales.deliver
  end


  desc "コース終了時に送られるメール"
  task "course:end" => :environment do
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

  desc "コースアラートのメール"
  task :alert => :environment do
      puts "アラートのメール開始"
      alerts = Alert.check

      if alerts.length != 0
        AlertMailer.course(alerts).deliver
      end
  end
end
