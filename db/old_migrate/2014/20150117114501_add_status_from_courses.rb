class AddStatusFromCourses < ActiveRecord::Migration
  def change
    add_column :courses, :status, :string, null: false, default: "draft"
  end
end
