class CreateCourseTasks < ActiveRecord::Migration
  def change
    create_table :course_tasks do |t|
      t.string :title, null: false
      t.datetime :start, null: false
      t.datetime :end
      t.boolean :all_day
      t.text :memo
      t.references :course, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
