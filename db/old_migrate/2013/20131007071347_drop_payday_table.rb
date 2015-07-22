class DropPaydayTable < ActiveRecord::Migration
  def up
     drop_table :invoices
     drop_table :line_items
  end

  def down

     create_table "invoices", force: true do |t|
       t.string   "bill_to"
       t.datetime "created_at"
       t.datetime "updated_at"
     end

     create_table "line_items", force: true do |t|
       t.decimal  "price"
       t.string   "description"
       t.integer  "quantity"
       t.integer  "invoice_id"
       t.datetime "created_at"
       t.datetime "updated_at"
     end
  end
end
