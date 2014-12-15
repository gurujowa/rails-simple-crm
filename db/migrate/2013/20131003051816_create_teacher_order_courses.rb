class CreateTeacherOrderCourses < ActiveRecord::Migration
  def up
    create_table :teacher_order_courses do |t|
      t.references("teacher_order")
      t.references("course")
    end

    remove_column :courses, :teacher_order_id
  end

  def down
     drop_table :teacher_order_courses
     add_column :courses, :teacher_order_id, :integer
  end
end
