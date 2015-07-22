class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.date :day, :null => false
      t.time :start_time, :null => false
      t.time :end_time, :null => false
      t.time :break_start
      t.time :break_end
      t.integer :teacher_id, :null => false
      t.integer :course_id, :null => false
      t.text :memo
      
      t.references("course")
      t.references("teacher")
            
      t.timestamps
    end
  end
end
