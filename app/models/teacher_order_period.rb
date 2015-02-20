class TeacherOrderPeriod < ActiveRecord::Base

  has_paper_trail 
  belongs_to :teacher_order

  validates :day, presence: true  
  validates :start_time, presence: true  
  validates :end_time, presence: true  
  validates :break_start, :presence => {if:  Proc.new {self.break_end.present?} , message: "休憩終了が入力されている場合、空には出来ません"}
  validates :break_end, :presence => {if:  Proc.new {self.break_start.present?} , message: "休憩開始が入力されている場合、空には出来ません"}


  def total_time
    b_time = 0
    c_time = end_date - start_date 
    b_time = break_end - break_start if break_end.present? && break_start.present?
    
    time = c_time - b_time 
    c_min = time / 60
    c_min
  end

  private
  def start_date
    return Time.local day.year, day.month, day.day, start_time.hour ,start_time.min
  end

  def end_date
    return Time.local day.year, day.month, day.day, end_time.hour ,end_time.min
  end
  

end
