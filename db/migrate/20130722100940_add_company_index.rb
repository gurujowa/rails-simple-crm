class AddCompanyIndex < ActiveRecord::Migration
  def change
    add_index :companies, :client_name
    add_index :companies, :created_at
    add_index :companies, :created_by
    add_index :companies, :updated_at
    add_index :companies, :updated_by
    add_index :companies, :prefecture
    add_index :companies, :city
  end
end
