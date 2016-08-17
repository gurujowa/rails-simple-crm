namespace :attend do
  desc "check teacher attend"

  task "monthly",["go"] => :environment do | task,args|
    periods = Period.where(day: Time.current.next_month.beginning_of_month...Time.current.next_month.end_of_month)
    t_p = periods.group_by { |p| p.teacher.id }
    t_p.each do |t|
      AttendMailer.monthly_mail(t[0], t[1], args.go).deliver_now
    end
  end

  task "today",["go"] => :environment do | task,args|
    if Time.current.workday?
      periods = Period.today
      periods.each do |p|
        AttendMailer.today_mail(p, args.go).deliver_now
      end
    end
  end

  task "tomorrow",["go"] => :environment do | task,args|
    if 1.day.since.workday?
      periods = Period.tomorrow_morning
      periods.each do |p|
        AttendMailer.tomorrow_mail(p, args.go).deliver_now
      end
    end
  end


  task "holiday",["go"] => :environment do | task,args|

    tomorrow = 1.day.since.beginning_of_day
    next_business_day = 1.business_day.from_now.beginning_of_day
    p tomorrow
    p next_business_day

    if tomorrow == next_business_day
      p "today is not holiday"
      next
    end
    periods = Period.where(day: tomorrow..next_business_day).where(attend_date: nil)
    periods.each do |p|
      AttendMailer.holiday_mail(p, args.go).deliver_now
    end

  end

  task "alert", ["type"] => :environment do | task,args |
    if args.type == "today"
      periods = Period.today
    elsif args.type == "tomorrow"
      periods = Period.tomorrow_morning
    else
      raise "args type only today or tomorrow"
    end
    if periods.present?
      AttendMailer.alert_mail(periods).deliver_now
    end
  end

end
