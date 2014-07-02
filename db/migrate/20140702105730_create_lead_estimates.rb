class CreateLeadEstimates < ActiveRecord::Migration
  def change
    create_table "lead_estimate_lines" do |t|
      t.string   "name",                    null: false
      t.integer  "unit_price",              null: false
      t.integer  "quantity",                null: false
      t.references  "lead_estimate",             null: false
      t.integer  "tax_rate",    default: 0, null: false
      t.text     "detail"
      t.timestamps
    end

    create_table "lead_estimates" do |t|
      t.references  "lead",                 null: false
      t.date     "expired"
      t.boolean  "send_flg",   default: false, null: false
      t.text     "memo"
      t.timestamps
    end
  end
end
