class CreateSubsityTasks < ActiveRecord::Migration
  def change
    create_table :subsity_tasks do |t|
      t.string :name
      t.integer :month
      t.integer :day
      t.string :depend
      t.belongs_to :subsity
      t.string :depend

      t.timestamps null: false
    end
  end
end
