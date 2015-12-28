class CreateLeadTasks < ActiveRecord::Migration
  def change
    create_table :lead_tasks do |t|
      t.string :name
      t.datetime :due_date
      t.text :memo
      t.datetime :complete_date
      t.belongs_to :lead

      t.timestamps null: false
    end
  end
end
