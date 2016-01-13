class ChangeSubsityMonthDayDefault < ActiveRecord::Migration
  def up

    drop_table :subsity_tasks
    create_table :subsity_tasks do |t|
      t.string :name, null: false
      t.integer :month, null: false, default: 0
      t.integer :day, null: false, default: 0
      t.string :depend, null: false
      t.belongs_to :subsity, null: false

      t.timestamps null: false
    end
  end
end
