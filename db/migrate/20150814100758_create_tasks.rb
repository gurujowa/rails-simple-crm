class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :day
      t.text :memo
      t.references :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
