class AddAdditionalFromTeacherOrders < ActiveRecord::Migration
  def change
    add_column :teacher_orders, :additional_price, :integer, :null => false, :default => 0
  end
end
