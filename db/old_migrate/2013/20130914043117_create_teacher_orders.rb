class CreateTeacherOrders < ActiveRecord::Migration
  def change
    create_table :teacher_orders do |t|
      t.integer :teacher_id
      t.integer :unit_price
      t.integer :memo
      t.boolean :invoice_flg
      t.boolean :payment_flg
      t.text :payment_term
      t.text :memo
      t.date :order_date
      t.date :payment_date

      t.timestamps
    end
  end
end
