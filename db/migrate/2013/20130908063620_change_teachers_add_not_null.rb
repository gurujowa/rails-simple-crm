class ChangeTeachersAddNotNull < ActiveRecord::Migration
  def self.up
      change_column :teachers, :first_kanji, :string, :null => false
      change_column :teachers, :last_kanji, :string, :null => false
      change_column :teachers, :last_kana, :string, :null => false
      change_column :teachers, :first_kana, :string, :null => false
      change_column :teachers, :work_possible, :integer, :null => false, :default => 0
  end

  def self.down
      change_column :teachers, :first_kanji, :string
      change_column :teachers, :last_kanji, :string
      change_column :teachers, :last_kana, :string
      change_column :teachers, :first_kana, :string
      change_column :teachers, :work_possible, :integer    
  end
end
