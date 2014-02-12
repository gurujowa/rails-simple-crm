# == Schema Information
#
# Table name: teacher_order_courses
#
#  id               :integer          not null, primary key
#  teacher_order_id :integer
#  course_id        :integer
#

class TeacherOrderCourse < ActiveRecord::Base
   belongs_to :teacher_order
   belongs_to :course
end
