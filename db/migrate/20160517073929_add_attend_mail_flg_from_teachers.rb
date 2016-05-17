class AddAttendMailFlgFromTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :attend_mail_flg, :boolean, default: true, null: false
  end
end
