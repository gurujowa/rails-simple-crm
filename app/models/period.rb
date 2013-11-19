class Period < ActiveRecord::Base
  has_paper_trail 
  validates :day, presence: true  
  validates :start_time, presence: true  
  validates :end_time, presence: true  
  validates :teacher_id, presence: true
  validates :break_start, :presence => {if:  Proc.new {self.break_end.present?} , message: "休憩終了が入力されている場合、空には出来ません"}
  validates :break_end, :presence => {if:  Proc.new {self.break_start.present?} , message: "休憩開始が入力されている場合、空には出来ません"}
  validates :resume_flg,  :inclusion => {:in => [true, false]}
  validates :report_flg,  :inclusion => {:in => [true, false]}
  belongs_to :teacher
  belongs_to :course

  def getTotal
    b_time = 0
    c_time = end_time - start_time 
    b_time = break_end - break_start if break_end.present? && break_start.present?
    
    time = c_time - b_time 
    c_min = time / 60
    c_min
  end

  def total_time
     getTotal
  end

  def start_time
    return Time.local day.year, day.month, day.day, read_attribute(:start_time).hour ,read_attribute(:start_time).min
  end

  def end_time
    return Time.local day.year, day.month, day.day, read_attribute(:end_time).hour ,read_attribute(:end_time).min
  end

  def save(*)
      cal = CrmApi::Calendar.instance
      event = cal.find_or_create_event_by_id google_id  do |e|
         e.title = %Q{#{course.company.client_name}【#{teacher.name}】}
         e.content = %Q{講師=#{teacher.name} \n コース名=#{course.name} \n }
         e.start_time = start_time
         e.end_time = end_time
      end
      logger.debug "-----------------------Google Calendar exported--------------------"
      logger.debug "event_id = " + event.id
      self.google_id = event.id
      super
  end

  def destroy
      cal = CrmApi::Calendar.instance
      event = cal.find_or_create_event_by_id google_id
      event.delete
      super
  end

end
