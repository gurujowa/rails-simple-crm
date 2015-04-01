class CreateCourseProgressTable < ActiveRecord::Migration
  def change
    create_table :course_progress_values do |t|
      t.references :period, null: false
      t.references :course_progress_header, null: false
      t.string :value
      t.timestamp
    end
    create_table :course_progress_headers do |t|
      t.string :name
      t.string :type, null: false
    end
  end
end
