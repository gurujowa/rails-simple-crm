class AddBillNumberFromPublicBill < ActiveRecord::Migration
  def change
    add_column :public_bills, :bill_number, :string
  end
end
