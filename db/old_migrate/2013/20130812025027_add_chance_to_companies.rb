class AddChanceToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :chance, :integer
  end
end
