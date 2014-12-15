class AddDFromCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :created_by, :string
    add_column :companies, :updated_by, :string
  end
end
