class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :type_id
      t.date :duedate
      t.string :name
      t.integer :assignee
      t.integer :created_by
      t.string :note
      t.integer :progress_id

      t.timestamps
    end
  end
end
