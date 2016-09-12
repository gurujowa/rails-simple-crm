# == Schema Information
#
# Table name: periods
#
#  id            :integer          not null, primary key
#  day           :date             not null
#  start_time    :time             not null
#  end_time      :time             not null
#  break_start   :time
#  break_end     :time
#  teacher_id    :integer
#  course_id     :integer
#  memo          :text
#  created_at    :datetime
#  updated_at    :datetime
#  resume_flg    :boolean          default(FALSE), not null
#  report_flg    :boolean          default(FALSE), not null
#  google_id     :string(255)
#  equipment_flg :boolean          default(FALSE), not null
#  attend_flg    :boolean          default(FALSE), not null
#

class Period < ActiveRecord::Base
  extend Enumerize
  has_paper_trail 

  has_many :period_tasks, dependent: :destroy

  validates :day, presence: true  
  validates :start_time, presence: true  
  validates :end_time, presence: true  
  validates :teacher_id, presence: true
  validates :break_start, :presence => {if:  Proc.new {self.break_end.present?} , message: "休憩終了が入力されている場合、空には出来ません"}
  validates :break_end, :presence => {if:  Proc.new {self.break_start.present?} , message: "休憩開始が入力されている場合、空には出来ません"}
  validates :resume_flg,  :inclusion => {:in => [true, false]}
  validates :report_flg,  :inclusion => {:in => [true, false]}

  belongs_to :order_sheet
  belongs_to :teacher
  belongs_to :course
  belongs_to :course_address
  belongs_to :user

  enumerize :resume_status, in: [:notstart, :unnecessary, :complete]

  @@color = ["MidnightBlue", "DarkViolet", "DarkSlateBlue", "Navy",  "Green", "DarkRed", "Gray", "Sienna", "DarkMagenta","LightPink"]

  scope :today, -> {
    start_time = Time.current.beginning_of_day.since(13.hour).to_s(:time)
    end_time = Time.current.end_of_day.to_s(:time)
    where(day: Time.current.all_day).where("start_time >= ?",start_time).where("start_time <= ?",end_time)
  }

  scope :tomorrow_morning, -> {
    where(day: 1.day.since.all_day).where("start_time >= ?",Time.current.beginning_of_day.to_s(:time)).where("start_time < ?",Time.current.beginning_of_day.since(13.hour).to_s(:time))
  }

  scope :day_between, -> from, to {

    if from.present? && to.present?
      from = DateTime.parse(from)
      to = DateTime.parse(to)
      where(day: from..to)
    elsif from.present?
      from = DateTime.parse(from)
      where('day >= ?', from)
    elsif to.present?
      to = DateTime.parse(to)
      where('day <= ?', to)
    end
  }

  def observe_color
    if self.user.present?
      key = self.user.id % 10
      return @@color[key]
    else
      return "Black"
    end
  end

  def title
    return "#{self.course.lead.corp_name} - #{self.course.name} - #{self.teacher.short_name} - #{self.day}"
  end

  def getTotal
    b_time = 0
    c_time = end_date - start_date 
    b_time = break_end - break_start if break_end.present? && break_start.present?
    
    time = c_time - b_time 
    c_min = time / 60
    c_min
  end

  def number
    periods = self.course.periods.sort_by{|p| p.start_date}
    return periods.index(self) + 1
  end

  def total_number
    return self.course.periods.length
  end


  def total_time_format
    b_time = 0
    c_time = end_date - start_date 
    b_time = break_end - break_start if break_end.present? && break_start.present?
    
    time = c_time - b_time
    c_min = time/ 60
    Time.at(time).gmtime.strftime("%H:%M")
  end

  def start_date
    return Time.local day.year, day.month, day.day, start_time.hour ,start_time.min
  end

  def end_date
    return Time.local day.year, day.month, day.day, end_time.hour ,end_time.min
  end

  def break_start(format=nil)
    if read_attribute(:break_start).present?
      time = Time.local day.year, day.month, day.day, read_attribute(:break_start).hour ,read_attribute(:break_start).min
      if format.present?
        time = time.to_s(format)
      end
      return time
    end
  end

  def user_name
    if self.user.present?
      return self.user.name
    end
  end

  def break_end(format=nil)
    if read_attribute(:break_end).present?
      time = Time.local day.year, day.month, day.day, read_attribute(:break_end).hour ,read_attribute(:break_end).min
      if format.present?
        time = time.to_s(format)
      end
      return time
    end
  end

  def order_status
    if self.order_sheet.blank?
      return :no_sheet
    else
      return self.order_sheet.status
    end
  end

  def resume_sent_text
    if self.checked_task.include?(PeriodTask.task_types[:unnecessary])
      return "(発送不要)"
    elsif self.resume_complete_flag
      return "(発送済)"
    end
  end


  def resume_complete_flag
    if self.checked_task.include?(PeriodTask.task_types[:unnecessary])
      return true
    elsif self.checked_task.include?(PeriodTask.task_types[:sent])
      return true
    else
      return false
    end
  end

  alias total_time getTotal

  def checked_task
    list = []
    self.period_tasks.each do |t|
      list << t["task_type"] if t.checked == true
    end
    return list
  end
end
