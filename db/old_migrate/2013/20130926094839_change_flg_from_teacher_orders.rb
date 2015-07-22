class ChangeFlgFromTeacherOrders < ActiveRecord::Migration
  def up
    remove_column  :teacher_orders, :invoice_flg
    remove_column  :teacher_orders, :payment_flg
    remove_column :teacher_orders , :payment_term
    add_column  :teacher_orders, :invoice_date,:date

  end

  def down
    add_column  :teacher_orders,:invoice_flg, :boolean
    add_column  :teacher_orders,:payment_flg, :boolean
    add_column  :teacher_orders,:payment_term, :string
    remove_column :teacher_orders, :invoice_date

  end
end
