class ChangeCourseFlg < ActiveRecord::Migration
  def up
    add_column :courses, :reception_seal_flg, :boolean, null: false, default: false
    add_column :courses, :cert_seal_flg, :boolean, null: false, default: false
    remove_column :courses, :report_flg, :boolean, null: false, default: false

    Course.update_all("cert_seal_flg = 1")
    Course.update_all("reception_seal_flg = 1")
    
  end

  def down
    remove_column :courses, :reception_seal_flg, :boolean, null: false, default: true
    remove_column :courses, :cert_seal_flg, :boolean, null: false, default: true
    add_column :courses, :report_flg, :boolean, null: false, default: false
  end
end
