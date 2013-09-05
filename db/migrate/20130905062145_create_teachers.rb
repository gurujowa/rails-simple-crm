class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :first_kana, :null => false
      t.string :last_kana, :null => false
      t.integer :work_possible, :null => false, :default => 0
      t.string :genre
      t.text :memo

      t.timestamps
    end
  end
end
