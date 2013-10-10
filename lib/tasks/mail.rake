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

  task :course_test => :environment do |task,args|
      puts "コースアラートの取得開始"
      courses = Course.all
      alert = CourseAlert.new
      courses.each do |c|
        alert.check c
      end

      alert.errors.each do |e|
        puts e
      end
  end

  task :course_alert => :environment do |task, args|
      puts "コースアラートのメール開始"

      courses = Course.all
      alert = CourseAlert.new
      courses.each do |c|
        alert.check c
      end

      if alert.errors.length != 0
        AlertMailer.course(alert).deliver
      end
  end
end
