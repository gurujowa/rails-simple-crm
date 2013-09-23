class CreateClientOrders < ActiveRecord::Migration
  def change
    create_table :client_orders do |t|
      t.integer :company_id, :null => false
      t.integer :price, :null => false
      t.boolean :invoice_flg, :null => false, :default => false
      t.boolean :payment_flg, :null => false, :default => false
      t.date :invoice_date
      t.date :payment_date
      t.text :memo

      t.timestamps
    end
  end
end
