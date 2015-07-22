class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, :null => false
      t.integer :company_id, :null => false
      t.boolean :order_flg, :null => false, :default => false
      t.boolean :book_flg, :null => false, :default => false
      t.boolean :resume_flg, :null => false, :default => false
      t.boolean :report_flg, :null => false, :default => false
      t.boolean :end_report_flg, :null => false, :default => false

      t.timestamps
    end
  end
end
