class CourseAlert

  attr_reader :errors

  def initialize
    @errors = []
  end

  def check(course)
    order_flg_check course
    book_flg_check course
    report_flg_check course
    end_form_flg_check course
  end

  def self.check_all
      courses = Course.all
      alert = self.new
      courses.each do |c|
        alert.check c
      end
      alert
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
