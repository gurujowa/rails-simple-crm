class CreateTeacherOrderLines < ActiveRecord::Migration
  def change
    create_table :teacher_order_lines do |t|
      t.references :teacher_order
      t.integer :price
      t.date :payment_date
      t.boolean :invoice_flg
      t.boolean :payment_flg
      t.string :memo
    end

    tos = TeacherOrder.all
    tos.each do |to|
      to.teacher_order_lines.create(price: to.price, payment_date: to.created_at, memo: to.description)
    end

    add_column :teacher_orders, :course_mention, :text
    remove_column :teacher_orders, :price, :integer
    remove_column :teacher_orders, :invoice_date, :date
    remove_column :teacher_orders, :payment_date, :date
  end
end
