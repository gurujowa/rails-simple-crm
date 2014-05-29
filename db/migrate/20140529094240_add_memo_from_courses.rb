class AddMemoFromCourses < ActiveRecord::Migration
  def change
    add_column :courses, :memo, :text
  end
end
