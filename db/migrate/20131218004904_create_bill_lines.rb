class CreateBillLines < ActiveRecord::Migration
  def change
    create_table :bill_lines do |t|
      t.string :name, null: false
      t.integer :tax_rate, null: false
      t.integer :unit_price, null: false
      t.references :bill, null: false
      t.integer :quantity, null: false, default: 1
      t.text :memo

      t.timestamps
    end
  end
end
