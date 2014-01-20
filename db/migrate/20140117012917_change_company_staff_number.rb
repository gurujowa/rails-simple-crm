class ChangeCompanyStaffNumber < ActiveRecord::Migration
  def change
    add_column :companies, :regular_staff, :integer, null: true
    add_column :companies, :nonregular_staff, :integer, null: true
    add_column :companies, :memo, :text, null: true
  end
end
