# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140213013838) do

  create_table "bill_lines", force: true do |t|
    t.string   "name",                   null: false
    t.integer  "tax_rate",               null: false
    t.integer  "unit_price",             null: false
    t.integer  "bill_id",                null: false
    t.integer  "quantity",   default: 1, null: false
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "billing_plan_lines", force: true do |t|
    t.date     "bill_date",       null: false
    t.date     "accural_date",    null: false
    t.text     "memo"
    t.integer  "billing_plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price"
  end

  add_index "billing_plan_lines", ["billing_plan_id"], name: "index_billing_plan_lines_on_billing_plan_id"

  create_table "billing_plans", force: true do |t|
    t.string   "name",                         null: false
    t.integer  "company_id",                   null: false
    t.integer  "tax_rate",     default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "publish_date"
    t.boolean  "send_flg",     default: false, null: false
  end

  add_index "billing_plans", ["company_id"], name: "index_billing_plans_on_company_id"

  create_table "bills", force: true do |t|
    t.string   "name",                                 null: false
    t.date     "duedate",                              null: false
    t.integer  "billing_plan_line_id",                 null: false
    t.boolean  "bill_flg",             default: false, null: false
    t.boolean  "payment_flg",          default: false, null: false
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bills", ["billing_plan_line_id"], name: "index_bills_on_billing_plan_line_id"

  create_table "campaigns", force: true do |t|
    t.string   "name"
    t.integer  "bill",       null: false
    t.integer  "sent",       null: false
    t.date     "start_date"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_orders", force: true do |t|
    t.integer  "company_id",                   null: false
    t.integer  "price",                        null: false
    t.boolean  "invoice_flg",  default: false, null: false
    t.boolean  "payment_flg",  default: false, null: false
    t.date     "invoice_date"
    t.date     "payment_date"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.string   "last_name",         null: false
    t.string   "first_name"
    t.string   "last_kana"
    t.string   "first_kana"
    t.string   "tel"
    t.string   "fax"
    t.string   "mail"
    t.integer  "gender",            null: false
    t.string   "official_position"
    t.integer  "company_id",        null: false
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.string   "client_name"
    t.string   "tel"
    t.string   "fax"
    t.string   "mail"
    t.integer  "status_id",                                         null: false
    t.string   "client_person"
    t.string   "zipcode"
    t.string   "prefecture"
    t.string   "city"
    t.string   "address"
    t.string   "building"
    t.string   "created_by"
    t.string   "updated_by"
    t.integer  "sales_person",     limit: 255,                      null: false
    t.date     "approach_day"
    t.integer  "chance"
    t.integer  "industry_id",                  default: 1,          null: false
    t.date     "appoint_plan"
    t.integer  "campaign_id",                                       null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "active_st",                    default: "notstart", null: false
    t.integer  "regular_staff"
    t.integer  "nonregular_staff"
    t.text     "memo"
  end

  add_index "companies", ["active_st"], name: "index_companies_on_active_st"
  add_index "companies", ["campaign_id"], name: "index_companies_on_campaign_id"
  add_index "companies", ["city"], name: "index_companies_on_city"
  add_index "companies", ["client_name"], name: "index_companies_on_client_name"
  add_index "companies", ["created_at"], name: "index_companies_on_created_at"
  add_index "companies", ["created_by"], name: "index_companies_on_created_by"
  add_index "companies", ["prefecture"], name: "index_companies_on_prefecture"
  add_index "companies", ["tel"], name: "index_companies_on_tel", unique: true
  add_index "companies", ["updated_at"], name: "index_companies_on_updated_at"
  add_index "companies", ["updated_by"], name: "index_companies_on_updated_by"

  create_table "company_contract_plans", force: true do |t|
    t.date     "duedate",    null: false
    t.text     "reason"
    t.text     "memo"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_contract_plans", ["company_id"], name: "index_company_contract_plans_on_company_id"

  create_table "company_payment_plans", force: true do |t|
    t.date     "duedate",    null: false
    t.text     "reason"
    t.text     "memo"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_payment_plans", ["company_id"], name: "index_company_payment_plans_on_company_id"

  create_table "company_proposed_plans", force: true do |t|
    t.date     "duedate",    null: false
    t.text     "reason"
    t.text     "memo"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_proposed_plans", ["company_id"], name: "index_company_proposed_plans_on_company_id"

  create_table "contacts", force: true do |t|
    t.integer  "company_id"
    t.text     "memo"
    t.string   "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "con_type"
  end

  create_table "courses", force: true do |t|
    t.string   "name",                               null: false
    t.integer  "company_id",                         null: false
    t.boolean  "order_flg",          default: false, null: false
    t.boolean  "book_flg",           default: false, null: false
    t.boolean  "resume_flg",         default: false, null: false
    t.boolean  "end_report_flg",     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "end_form_flg",       default: false, null: false
    t.boolean  "diploma_flg",        default: false, null: false
    t.boolean  "reception_seal_flg", default: false, null: false
    t.boolean  "cert_seal_flg",      default: false, null: false
  end

  create_table "estimate_lines", force: true do |t|
    t.string   "name",                    null: false
    t.integer  "unit_price",              null: false
    t.integer  "quantity",                null: false
    t.integer  "estimate_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tax_rate",    default: 0, null: false
    t.text     "detail"
  end

  create_table "estimates", force: true do |t|
    t.integer  "company_id",                 null: false
    t.date     "expired"
    t.boolean  "send_flg",   default: false, null: false
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", force: true do |t|
    t.integer  "company_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
  end

  create_table "periods", force: true do |t|
    t.date     "day",                           null: false
    t.time     "start_time",                    null: false
    t.time     "end_time",                      null: false
    t.time     "break_start"
    t.time     "break_end"
    t.integer  "teacher_id"
    t.integer  "course_id"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "resume_flg",    default: false, null: false
    t.boolean  "report_flg",    default: false, null: false
    t.string   "google_id"
    t.boolean  "equipment_flg", default: false, null: false
    t.boolean  "attend_flg",    default: false, null: false
  end

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.string   "rank"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "dm_st",      default: false
  end

  create_table "task_types", force: true do |t|
    t.string   "name"
    t.integer  "default_due"
    t.integer  "default_assignee"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.integer  "type_id"
    t.date     "duedate"
    t.string   "name"
    t.integer  "assignee"
    t.integer  "created_by"
    t.string   "note"
    t.integer  "progress_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "teacher_order_courses", force: true do |t|
    t.integer "teacher_order_id"
    t.integer "course_id"
  end

  create_table "teacher_orders", force: true do |t|
    t.integer  "teacher_id"
    t.integer  "unit_price"
    t.text     "memo"
    t.date     "order_date"
    t.date     "payment_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "additional_price", default: 0, null: false
    t.integer  "students"
    t.string   "description"
    t.date     "invoice_date"
  end

  create_table "teachers", force: true do |t|
    t.string   "first_kanji",                 null: false
    t.string   "last_kanji",                  null: false
    t.string   "first_kana",                  null: false
    t.string   "last_kana",                   null: false
    t.integer  "work_possible",   default: 0, null: false
    t.string   "genre"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "orientation_flg"
    t.boolean  "profile_flg"
    t.boolean  "photo_flg"
    t.boolean  "regist_flg"
    t.boolean  "contract_flg"
    t.integer  "bill"
    t.string   "tel"
    t.string   "email"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
