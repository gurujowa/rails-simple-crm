class Alert
  attr_accessor :courses, :companies, :periods
  
  def self.check
    alerts = self.new
    alerts.companies = CompanyAlert.check_all.errors
    alerts.courses = CourseAlert.check_all(:alert).errors
    alerts.periods = PeriodAlert.check_all(:alert).errors
    alerts
  end

  def self.task
    alerts = self.new
    alerts.companies = CompanyAlert.check_all.errors
    alerts.courses = CourseAlert.check_all(:task).errors
    alerts.periods = PeriodAlert.check_all(:task).errors
    alerts
  end

  def all
    return @companies.concat(@courses).concat(@periods)
  end

  def length
    length = @companies.length
    length += @courses.length
    length += @periods.length
    length
  end

end
