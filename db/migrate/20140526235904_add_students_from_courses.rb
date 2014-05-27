class AddStudentsFromCourses < ActiveRecord::Migration
  def change
    add_column :courses, :students, :integer
  end
end
