class CreateLeadTasks < ActiveRecord::Migration
  def change
    create_table :lead_tasks do |t|
      t.string :name, null: false
      t.date :due_date, null: false
      t.date :complete_date
      t.text :memo
      t.references :lead
      t.references :lead_subsity

      t.timestamps null: false
    end
  end
end
