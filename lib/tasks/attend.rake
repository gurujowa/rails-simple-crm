namespace :attend do
  desc "check teacher attend"

  task "teacher",["to"] => :environment do | task, args|
    periods = Period.today
    periods.each do |p|
      AttendMailer.teacher_mail(p, args.to).deliver_now
    end
  end

end
