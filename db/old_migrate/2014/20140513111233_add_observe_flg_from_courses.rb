class AddObserveFlgFromCourses < ActiveRecord::Migration
  def change
    add_column :courses, :observe_flg, :boolean, null: false, default: false
  end
end
