class AddAttendeeTableFlgFromCourses < ActiveRecord::Migration
  def change
    add_column :courses, :attendee_table_flg, :boolean, null: false, default: false
  end
end
