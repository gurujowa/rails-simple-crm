class Period < ActiveRecord::Base
  validates :day, presence: true  
  validates :start_time, presence: true  
  validates :end_time, presence: true  
  validates :teacher_id, presence: true
  validates :break_start, :presence => {if:  Proc.new {self.break_end.present?} , message: "休憩終了が入力されている場合、空には出来ません"}
  validates :break_end, :presence => {if:  Proc.new {self.break_start.present?} , message: "休憩開始が入力されている場合、空には出来ません"}
  validates :resume_flg,  :inclusion => {:in => [true, false]}
  validates :report_flg,  :inclusion => {:in => [true, false]}

  def getTotal
    b_time = 0
    c_time = end_time - start_time 
    b_time = break_end - break_start if break_end.present? && break_start.present?
    
    time = c_time - b_time 
    c_min = time / 60
    c_min
  end
end
