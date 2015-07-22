class AddUniqueFromCompanies < ActiveRecord::Migration
  def change
    add_index :companies, :tel, :unique => true
  end
end
