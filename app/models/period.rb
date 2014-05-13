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
  belongs_to :user

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

end
