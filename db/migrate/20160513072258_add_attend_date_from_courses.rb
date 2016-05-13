class AddAttendDateFromCourses < ActiveRecord::Migration
  def change
    add_column :periods, :attend_date, :datetime
  end
end
