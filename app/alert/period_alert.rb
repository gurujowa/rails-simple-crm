class PeriodAlert

  def initialize
    @errors = []
  end

  def check(course, type)
    unless period_null course
      return false
    end

    if type == :alert
      period_resume_flg_check course, 4.days.since
      period_equipment_flg_check course, 7.days.since
      period_attend_flg_check course, 4.days.ago
      period_report_flg_check course, 4.days.ago
    elsif type == :task
      period_resume_flg_check course, 7.days.since
      period_equipment_flg_check course, 14.days.since
      period_attend_flg_check course, 0.days.ago
      period_report_flg_check course, 0.days.ago
    else
      raise "Alert type is only 'alert' and 'task'"
    end
  end

  def self.check_all(type)
      courses = Course.all
      alert = self.new
      courses.each do |c|
        alert.check c, type
      end
      alert
  end

  def errors
    @errors
  end

  private
  def period_resume_flg_check c, day
    period_flg_check c, day, :resume_flg, "レジュメが届いていないコマがあります。"
  end
  def period_equipment_flg_check c, day
    period_flg_check c, day, :equipment_flg, "備品が揃っていないコマがあります。"
  end
  def period_report_flg_check c, day
    period_flg_check c, day, :report_flg, "実施報告書が届いていないコマがあります。"
  end
  def period_attend_flg_check c, day
    period_flg_check c, day, :attend_flg, "出欠表が届いていないコマがあります。"
  end

  def period_flg_check(c, compare, flg, message)
    c.periods.each do |p|
      if p.day <= compare and p.read_attribute(flg) == false
        push_error c, message, p
      end
    end
  end

  def period_null c
    if c.periods.length == 0
      push_error c, "コマが未入力のコースがあります。"
      return false
    end

    return true
  end


  def push_error c, message, p
    message = PeriodAlertMessage.new c, message, p
    @errors.push message
  end


end

class PeriodAlertMessage
  attr_reader :course, :period, :message

  def initialize course, message, period
    @course = course
    @message = message
    @period = period
  end

  def day
    period.day
  end

  def client_name
    @course.company.client_name
  end

  def mail_message
    message = %Q{#{@message} 会社名：#{@course.company.client_name}, コース名：#{@course.name}, ID: #{@course.id}, 日付:#{@day}}

    message
  end

  def to_s
    mail_message
  end
end
