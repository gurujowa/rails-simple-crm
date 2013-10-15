class AddEndFormFlgFromCourses < ActiveRecord::Migration
  def change
    add_column :courses, :end_form_flg, :boolean, null: false, default: false
  end
end
