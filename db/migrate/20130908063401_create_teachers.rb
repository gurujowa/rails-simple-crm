class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :first_kanji
      t.string :last_kanji
      t.string :first_kana
      t.string :last_kana
      t.integer :work_possible
      t.string :genre
      t.text :memo

      t.timestamps
    end
  end
end
