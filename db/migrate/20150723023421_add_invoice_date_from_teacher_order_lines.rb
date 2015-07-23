class AddInvoiceDateFromTeacherOrderLines < ActiveRecord::Migration
  def change
    add_column :teacher_order_lines, :invoice_date, :date
  end
end
