class AddPriceToTeacherOrders < ActiveRecord::Migration
  def change
    add_column :teacher_orders, :price, :integer, null: false, default: 0
    add_column :teacher_orders, :price_detail, :string
    remove_column :teacher_orders, :unit_price, :integer
    remove_column :teacher_orders, :additional_price, :integer
  end
end
