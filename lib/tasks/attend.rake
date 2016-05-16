namespace :attend do
  desc "check teacher attend"

  task "teacher",["mode"] => :environment do | task,args|

    if args.mode == "development"
      Rails.env = "development"
    elsif args.mode == "production"
      Rails.env = "production"
    elsif args.mode.blank?
      #nothing process
    else
      raise "invalid mode #{args.mode}"
    end

    periods = Period.today
    periods.each do |p|
      AttendMailer.teacher_mail(p).deliver_now
    end
  end


  task "alert" => :environment do | task |
      AttendMailer.alert_mail().deliver_now
  end

end
