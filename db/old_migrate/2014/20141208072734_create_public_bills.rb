class CreatePublicBills < ActiveRecord::Migration
  def change
    create_table :public_bills do |t|
      t.string :name, null: false
      t.date :publish_date
      t.boolean :send_flg, null:false, default: false
      t.string :company_name, null: false
      t.date :invoice_date
      t.date :payment_date
      t.text :memo

      t.timestamps
    end


    create_table "public_bill_lines", force: true do |t|
      t.string   "name",                    null: false
      t.integer  "unit_price",              null: false
      t.integer  "quantity",                null: false
      t.references  "public_bill",             null: false
      t.integer  "tax_rate",    default: 0, null: false
      t.text     "detail"

      t.timestamps
    end
  end
end
