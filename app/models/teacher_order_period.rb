class TeacherOrderPeriod < ActiveRecord::Base

  has_paper_trail 
  belongs_to :teacher_order

  validates :day, presence: true  
  validates :start_time, presence: true  
  validates :end_time, presence: true  
  validates :break_start, :presence => {if:  Proc.new {self.break_end.present?} , message: "休憩終了が入力されている場合、空には出来ません"}
  validates :break_end, :presence => {if:  Proc.new {self.break_start.present?} , message: "休憩開始が入力されている場合、空には出来ません"}

end
