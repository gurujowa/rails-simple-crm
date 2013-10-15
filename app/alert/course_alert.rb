class CourseAlert

  def initialize
    @errors = []
  end

  def check(course)
    unless period_null course
      return false
    end

    order_flg_check course
    book_flg_check course
    report_flg_check course
    end_form_flg_check course

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
  def order_flg_check(c)
    course_flg_check c, 14.days.since, c.order_flg, "発注書フラグがオフになっています。"
  end
  def book_flg_check(c)
    course_flg_check c, 14.days.since, c.book_flg, "書籍送付フラグがオフになっています。"
  end
  def report_flg_check(c)
    course_flg_check c, 7.days.since, c.report_flg, "３点セットフラグがオフになっています。"
  end
  def end_form_flg_check(c)
    course_end_check c, 30.days.ago, c.end_form_flg, "支給申請が完了していません。"
  end

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


  def course_end_check(c, compare, flg, message)
    if c.end_date >= compare
      return false
    end

    if flg == false
      push_error  c, message
    end
  end

  def course_flg_check(c, compare, flg, message)
    if c.start_date >= compare
      return false
    end

    if flg == false
      push_error  c, message
    end
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
#    message = %Q{#{message} 会社名：#{c.company.client_name}, コース名：#{c.name}, ID: #{c.id}}
#    if day.present?
#      message << %Q{, 日付:#{day}}
#    end
    message = CourseAlertMessage.new c, message
    message.day = day
    @errors.push message
  end


end

class CourseAlertMessage
  attr_accessor :course, :day, :message

  def initialize course, message
    @course = course
    @message = message
  end


  def client_name
    @course.company.client_name
  end


  def start_date
    if @day.present?
      return @day
    else
      @course.start_date
    end
  end

  def end_date
    if @day.present?
      return @day
    else
      @course.end_date
    end
  end

  def to_s
    message = %Q{#{@message} 会社名：#{@course.company.client_name}, コース名：#{@course.name}, ID: #{@course.id}}
    if day.present?
      message << %Q{, 日付:#{@day}}
    end

    message
  end
end
