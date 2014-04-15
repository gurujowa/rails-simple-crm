class AddDirectorToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :director_id, :integer
  end
end
