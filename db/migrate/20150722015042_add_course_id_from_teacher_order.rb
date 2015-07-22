class AddCourseIdFromTeacherOrder < ActiveRecord::Migration
  def change
    add_column :teacher_orders, :course_id, :integer
  end
end
