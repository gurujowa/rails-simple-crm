class CreateOrderSheetTable < ActiveRecord::Migration
  def change
    create_table :order_sheets do |t|
      t.string  "title", null: false
      t.string  "send_to", null: false
      t.date     "order_date"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "description",  limit: 255
      t.string   "status",       limit: 255,   default: "draft", null: false
      t.text     "mention"
      t.text     "course_info"
      t.text     "memo"
      t.timestamp
    end

    create_table :order_sheet_lines do |f|
      f.integer "order_sheet_id"
      f.integer "price"
      f.date    "invoice_date"
      f.date    "payment_date"
      f.boolean "invoice_flg", default: false, null: false
      f.boolean "payment_flg", default: false, null: false
      f.text  "memo"
      f.timestamp
    end
  end
end
