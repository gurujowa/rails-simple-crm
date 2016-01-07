class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name,null: false
      t.datetime :due_date
      t.text :memo
      t.datetime :complete_date
      t.belongs_to :lead

      t.timestamps null: false
    end
  end
end
