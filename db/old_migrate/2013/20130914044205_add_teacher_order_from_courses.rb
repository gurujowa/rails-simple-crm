class AddTeacherOrderFromCourses < ActiveRecord::Migration
  def change
    add_column :courses, :teacher_order_id, :integer
  end
end
