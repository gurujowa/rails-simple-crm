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

ActiveRecord::Schema.define(version: 20130914044205) do

  create_table "companies", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.string   "client_name"
    t.string   "tel"
    t.string   "fax"
    t.string   "mail"
    t.integer  "status_id",                 null: false
    t.string   "client_person"
    t.string   "zipcode"
    t.string   "prefecture"
    t.string   "city"
    t.string   "address"
    t.string   "building"
    t.string   "lead"
    t.string   "created_by"
    t.string   "updated_by"
    t.string   "sales_person"
    t.date     "approach_day"
    t.integer  "bill"
    t.integer  "chance"
    t.integer  "industry_id",   default: 1, null: false
    t.date     "payment_plan"
    t.date     "appoint_plan"
    t.date     "contract_plan"
    t.date     "proposed_plan"
  end

  add_index "companies", ["city"], name: "index_companies_on_city"
  add_index "companies", ["client_name"], name: "index_companies_on_client_name"
  add_index "companies", ["created_at"], name: "index_companies_on_created_at"
  add_index "companies", ["created_by"], name: "index_companies_on_created_by"
  add_index "companies", ["prefecture"], name: "index_companies_on_prefecture"
  add_index "companies", ["updated_at"], name: "index_companies_on_updated_at"
  add_index "companies", ["updated_by"], name: "index_companies_on_updated_by"

  create_table "contacts", force: true do |t|
    t.integer  "company_id"
    t.text     "memo"
    t.string   "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "con_type"
  end

  create_table "courses", force: true do |t|
    t.string   "name",                             null: false
    t.integer  "company_id",                       null: false
    t.boolean  "order_flg",        default: false, null: false
    t.boolean  "book_flg",         default: false, null: false
    t.boolean  "resume_flg",       default: false, null: false
    t.boolean  "report_flg",       default: false, null: false
    t.boolean  "end_report_flg",   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "teacher_order_id"
  end

  create_table "industries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "logs", force: true do |t|
    t.integer  "company_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
  end

  create_table "periods", force: true do |t|
    t.date     "day",                         null: false
    t.time     "start_time",                  null: false
    t.time     "end_time",                    null: false
    t.time     "break_start"
    t.time     "break_end"
    t.integer  "teacher_id"
    t.integer  "course_id"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "resume_flg",  default: false, null: false
    t.boolean  "report_flg",  default: false, null: false
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

  create_table "teacher_orders", force: true do |t|
    t.integer  "teacher_id"
    t.integer  "unit_price"
    t.text     "memo"
    t.boolean  "invoice_flg"
    t.boolean  "payment_flg"
    t.text     "payment_term"
    t.date     "order_date"
    t.date     "payment_date"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
