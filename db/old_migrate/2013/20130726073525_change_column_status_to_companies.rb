class ChangeColumnStatusToCompanies < ActiveRecord::Migration
  def self.up
    change_column :companies, :status_id, :integer, :null => false
  end
  
  def self.down
    change_column :companies, :status_id, :integer, :null => true    
  end
end
