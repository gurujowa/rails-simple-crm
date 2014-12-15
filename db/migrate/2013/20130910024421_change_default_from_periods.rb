class ChangeDefaultFromPeriods < ActiveRecord::Migration
  def self.up
      change_column :periods, :report_flg, :boolean, :null => false, :default => false
      change_column :periods, :resume_flg, :boolean, :null => false, :default => false
  end
  
  def self.down
      change_column :periods, :report_flg, :boolean
      change_column :periods, :resume_flg, :boolean    
  end
end
