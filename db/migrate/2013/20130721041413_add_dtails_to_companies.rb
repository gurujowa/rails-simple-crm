class AddDtailsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :category, :string
    add_column :companies, :client_name, :string
    add_column :companies, :tel, :string
    add_column :companies, :fax, :string
    add_column :companies, :mail, :string
    add_column :companies, :status_id, :integer
    add_column :companies, :client_person, :string
    add_column :companies, :zipcode, :string
    add_column :companies, :prefecture, :string
    add_column :companies, :city, :string
    add_column :companies, :address, :string
    add_column :companies, :building, :string
    add_column :companies, :lead, :string
  end
end
