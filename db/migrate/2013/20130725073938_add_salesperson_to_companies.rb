class AddSalespersonToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :sales_person, :string
  end
end
