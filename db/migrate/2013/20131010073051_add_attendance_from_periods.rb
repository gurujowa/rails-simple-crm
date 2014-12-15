class AddAttendanceFromPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :attend_flg, :boolean, null: false, default: false
  end
end
