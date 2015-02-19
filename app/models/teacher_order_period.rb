class TeacherOrderPeriod < ActiveRecord::Base

  has_paper_trail 
  belongs_to :teacher_order

  validates :day, presence: true  
  validates :start_time, presence: true  
  validates :end_time, presence: true  
  validates :break_start, :presence => {if:  Proc.new {self.break_end.present?} , message: "�x�e�I�������͂���Ă���ꍇ�A��ɂ͏o���܂���"}
  validates :break_end, :presence => {if:  Proc.new {self.break_start.present?} , message: "�x�e�J�n�����͂���Ă���ꍇ�A��ɂ͏o���܂���"}

end
