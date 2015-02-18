class TeacherOrderPeriod < ActiveRecord::Base

  has_paper_trail 
  belongs_to :teacher_order

end
