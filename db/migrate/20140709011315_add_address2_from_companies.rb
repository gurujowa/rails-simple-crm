class AddAddress2FromCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :tel2, :string
    add_column :companies, :fax2, :string
    add_column :companies, :zipcode2, :string
    add_column :companies, :prefecture2, :string
    add_column :companies, :city2, :string
    add_column :companies, :address2, :string
    add_column :companies, :building2, :string
  end
end
