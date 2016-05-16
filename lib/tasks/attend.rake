namespace :attend do
  desc "check teacher attend"

  task "teacher",["go"] => :environment do | task,args|
    periods = Period.today
    periods.each do |p|
      AttendMailer.teacher_mail(p, args.go).deliver_now
    end
  end


  task "alert" => :environment do | task |
      AttendMailer.alert_mail().deliver_now
  end

end
