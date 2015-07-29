class AddCompanyInfoFromOrderSheets < ActiveRecord::Migration
  def change
    add_column :order_sheets, :company_info, :text
    remove_column :order_sheets, :description, :string
  end
end
