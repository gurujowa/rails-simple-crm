class AddDiplomaFromCourses < ActiveRecord::Migration
  def change
    add_column :courses, :diploma_flg, :boolean, null: false, default: false
  end
end
