class CreateTaskTypes < ActiveRecord::Migration
  def change
    create_table :task_types do |t|
      t.string :name
      t.integer :default_due
      t.integer :default_assignee
      t.string :group

      t.timestamps
    end
  end
end
