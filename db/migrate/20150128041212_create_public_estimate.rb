class CreatePublicEstimate < ActiveRecord::Migration
  def change
    create_table "public_estimate_lines", force: true do |t|
      t.string   "name",                    null: false
      t.integer  "unit_price",              null: false
      t.integer  "quantity",                null: false
      t.integer  "public_estimate_id",             null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "tax_rate",    default: 0, null: false
      t.text     "detail"
    end

    create_table "public_estimates", force: true do |t|
      t.integer  "client_id",                        null: false
      t.date     "expired"
      t.boolean  "send_flg",     default: false,     null: false
      t.text     "memo"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "client_type",  default: "company", null: false
      t.string   "display_name"
    end
  end
end
