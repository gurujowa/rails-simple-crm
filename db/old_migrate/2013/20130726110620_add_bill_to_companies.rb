class AddBillToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :bill, :integer
  end
end
