class CourseAlert

  attr_reader :errors

  def initialize
    @errors = []
  end

  def check(course, type)
    unless course_present_check course
      return false
    end

    if course.periods.blank?
      return false
    end

    if type == :alert
      order_flg_check course,14.days.since
      book_flg_check course, 14.days.since
      attendee_table_flg_check course, 3.days.since
#      reception_seal_flg_check course,30.days.since
#      cert_seal_flg_check course, 3.days.since
#      end_form_flg_check course, 30.days.ago
      observe_check course
      diploma_flg_check course, 7.days.since
    elsif type == :task
      order_flg_check course,21.days.since
      book_flg_check course, 21.days.since
#      reception_seal_flg_check course,40.days.since
#      cert_seal_flg_check course, 14.days.since
#      end_form_flg_check course, 0.days.ago
      attendee_table_flg_check course, 7.days.since
      observe_check course
      diploma_flg_check course, 14.days.since
    else
      raise "Alert type is only 'alert' and 'task'"
    end
  end

  def self.check_all type
      courses = Course.all
      alert = self.new
      courses.each do |c|
        alert.check c,type
      end
      alert
  end


  private

  def course_present_check c
    unless c.present?
      push_error  c, "コース情報がありません"
      return false
    end

    return true

  end

  def order_flg_check(c, day)
    course_start_check c, day, c.order_flg, "発注書の送付が完了していません。"
  end
  def book_flg_check(c, day)
    course_start_check c, day, c.book_flg, "書籍の送付が完了していません。"
  end
  def reception_seal_flg_check(c, day)
    course_start_check c, day, c.reception_seal_flg, "窓口受領印が届いていません"
  end
  def cert_seal_flg_check(c, day)
    course_end_check c, day, c.cert_seal_flg, "労働局受領印が届いていません"
  end
  def attendee_table_flg_check(c, day)
    course_start_check c, day, c.attendee_table_flg, "出欠表の作成が完了していません"
  end
  def end_form_flg_check(c, day)
    course_end_check c, day, c.end_form_flg, "支給申請が完了していません。"
  end
  def diploma_flg_check(c, day)
    course_end_check c, day, c.diploma_flg, "表彰状の準備ができていません"
  end

  def observe_check(c)
    if c.observe_flg == false
      return false
    end
    periods = c.periods
    observe_flg = false

    periods.each do |p|
      if p.user_id.present?
        observe_flg = true
      end
    end

    if observe_flg.blank?
      push_error  c, "立会人が一人も入力されていません"
    end
  end


  def course_end_check(c, compare, flg, message)
    if c.end_date >= compare
      return false
    end

    if flg == false
      push_error  c, message
    end
  end

  def course_start_check(c, compare, flg, message)
    if c.start_date >= compare
      return false
    end

    if flg == false
      push_error  c, message
    end
  end



  def push_error c, message
    message = CourseAlertMessage.new c, message
    @errors.push message
  end


end

class CourseAlertMessage
  attr_accessor :course, :message

  def initialize course, message
    @course = course
    @message = message
  end


  def client_name
    @course.company.client_name
  end


  def start_date
      @course.start_date
  end

  def end_date
      @course.end_date
  end

  def mail_message
    message = %Q{#{@message} 会社名：#{@course.company.client_name}, コース名：#{@course.name}, ID: #{@course.id}}
    message
  end

  def to_s
    mail_message
  end
end
