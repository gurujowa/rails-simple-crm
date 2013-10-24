class PeriodAlert

  def initialize
    @errors = []
  end

  def check(course)
    unless period_null course
      return false
    end

    period_resume_flg_check course
    period_equipment_flg_check course
    period_attend_flg_check course
    period_report_flg_check course
  end

  def self.check_all
      courses = Course.all
      alert = self.new
      courses.each do |c|
        alert.check c
      end
      alert
  end

  def errors
    @errors
  end

  private
  def period_resume_flg_check c
    period_flg_check c, 7.days.since, :resume_flg, "レジュメが届いていないコマがあります。"
  end
  def period_equipment_flg_check c
    period_flg_check c, 7.days.since, :equipment_flg, "備品が揃っていないコマがあります。"
  end
  def period_report_flg_check c
    period_flg_check c, 2.days.ago, :report_flg, "実施報告書が届いていないコマがあります。"
  end
  def period_attend_flg_check c
    period_flg_check c, 2.days.ago, :attend_flg, "出欠表が届いていないコマがあります。"
  end

  def period_flg_check(c, compare, flg, message)
    c.periods.each do |p|
      if p.day <= compare and p.read_attribute(flg) == false
        push_error c, message, p.day
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


  def push_error c, message, day = nil
    message = PeriodAlertMessage.new c, message, day
    @errors.push message
  end


end

class PeriodAlertMessage
  attr_reader :course, :day, :message

  def initialize course, message, day
    @course = course
    @message = message
    @day = day
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
