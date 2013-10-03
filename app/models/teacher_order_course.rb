class TeacherOrderCourse < ActiveRecord::Base
   belongs_to :teacher_order
   belongs_to :course
end
