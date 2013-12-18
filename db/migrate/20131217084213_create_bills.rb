class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :name, null: false
      t.date :duedate, null: false
      t.references :billing_plan_line, index: true, null:false
      t.boolean :bill_flg, null:false, default: false
      t.boolean :payment_flg, null: false, default: false
      t.text :memo

      t.timestamps
    end
  end
end
