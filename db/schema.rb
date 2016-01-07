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

ActiveRecord::Schema.define(version: 20151224090225) do

  create_table "billing_plan_lines", force: :cascade do |t|
    t.date     "bill_date",                     null: false
    t.date     "accural_date",                  null: false
    t.text     "memo",            limit: 65535
    t.integer  "billing_plan_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price",           limit: 4
  end

  add_index "billing_plan_lines", ["billing_plan_id"], name: "index_billing_plan_lines_on_billing_plan_id", using: :btree

  create_table "billing_plans", force: :cascade do |t|
    t.string   "name",         limit: 255,                 null: false
    t.integer  "tax_rate",     limit: 4,   default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "publish_date"
    t.boolean  "send_flg",                 default: false, null: false
    t.string   "display_name", limit: 255
    t.integer  "lead_id",      limit: 4,                   null: false
  end

  create_table "campaigns", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "bill",       limit: 4,     null: false
    t.integer  "sent",       limit: 4,     null: false
    t.date     "start_date"
    t.text     "memo",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_orders", force: :cascade do |t|
    t.integer  "company_id",   limit: 4,                     null: false
    t.integer  "price",        limit: 4,                     null: false
    t.boolean  "invoice_flg",                default: false, null: false
    t.boolean  "payment_flg",                default: false, null: false
    t.date     "invoice_date"
    t.date     "payment_date"
    t.text     "memo",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: :cascade do |t|
    t.string   "last_name",         limit: 255,   null: false
    t.string   "first_name",        limit: 255
    t.string   "last_kana",         limit: 255
    t.string   "first_kana",        limit: 255
    t.string   "tel",               limit: 255
    t.string   "fax",               limit: 255
    t.string   "mail",              limit: 255
    t.integer  "gender",            limit: 4,     null: false
    t.string   "official_position", limit: 255
    t.integer  "company_id",        limit: 4,     null: false
    t.text     "memo",              limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category",         limit: 255
    t.string   "client_name",      limit: 255
    t.string   "tel",              limit: 255
    t.string   "fax",              limit: 255
    t.string   "mail",             limit: 255
    t.string   "zipcode",          limit: 255
    t.string   "prefecture",       limit: 255
    t.string   "city",             limit: 255
    t.string   "address",          limit: 255
    t.string   "building",         limit: 255
    t.string   "created_by",       limit: 255
    t.string   "updated_by",       limit: 255
    t.integer  "industry_id",      limit: 4,     default: 1,          null: false
    t.integer  "campaign_id",      limit: 4,                          null: false
    t.string   "active_st",        limit: 255,   default: "notstart", null: false
    t.integer  "regular_staff",    limit: 4
    t.integer  "nonregular_staff", limit: 4
    t.text     "memo",             limit: 65535
    t.string   "tel2",             limit: 255
    t.string   "fax2",             limit: 255
    t.string   "zipcode2",         limit: 255
    t.string   "prefecture2",      limit: 255
    t.string   "city2",            limit: 255
    t.string   "address2",         limit: 255
    t.string   "building2",        limit: 255
  end

  add_index "companies", ["active_st"], name: "index_companies_on_active_st", using: :btree
  add_index "companies", ["campaign_id"], name: "index_companies_on_campaign_id", using: :btree
  add_index "companies", ["city"], name: "index_companies_on_city", using: :btree
  add_index "companies", ["client_name"], name: "index_companies_on_client_name", using: :btree
  add_index "companies", ["created_at"], name: "index_companies_on_created_at", using: :btree
  add_index "companies", ["created_by"], name: "index_companies_on_created_by", using: :btree
  add_index "companies", ["prefecture"], name: "index_companies_on_prefecture", using: :btree
  add_index "companies", ["tel"], name: "index_companies_on_tel", unique: true, using: :btree
  add_index "companies", ["updated_at"], name: "index_companies_on_updated_at", using: :btree
  add_index "companies", ["updated_by"], name: "index_companies_on_updated_by", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "company_id", limit: 4
    t.text     "memo",       limit: 65535
    t.string   "created_by", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "con_type",   limit: 4
  end

  create_table "course_tasks", force: :cascade do |t|
    t.string   "title",      limit: 255,   null: false
    t.datetime "start",                    null: false
    t.datetime "end"
    t.boolean  "all_day"
    t.text     "memo",       limit: 65535
    t.integer  "course_id",  limit: 4,     null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "course_tasks", ["course_id"], name: "index_course_tasks_on_course_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "company_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address",     limit: 255
    t.string   "station",     limit: 255
    t.string   "responsible", limit: 255
    t.string   "tel",         limit: 255
    t.integer  "students",    limit: 4
    t.text     "memo",        limit: 65535
    t.integer  "user_id",     limit: 4
    t.string   "status",      limit: 255,   default: "draft"
    t.integer  "lead_id",     limit: 4,                       null: false
  end

  create_table "estimate_lines", force: :cascade do |t|
    t.string   "name",        limit: 255,               null: false
    t.integer  "unit_price",  limit: 4,                 null: false
    t.integer  "quantity",    limit: 4,                 null: false
    t.integer  "estimate_id", limit: 4,                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tax_rate",    limit: 4,     default: 0, null: false
    t.text     "detail",      limit: 65535
  end

  create_table "estimate_subsities", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "price",       limit: 4,   default: 0, null: false
    t.integer  "people",      limit: 4
    t.integer  "estimate_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estimates", force: :cascade do |t|
    t.date     "expired"
    t.boolean  "send_flg",                   default: false, null: false
    t.text     "memo",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name", limit: 255
    t.date     "publish_date"
    t.integer  "lead_id",      limit: 4
  end

  add_index "estimates", ["lead_id"], name: "fk_rails_2c1af8602b", using: :btree

  create_table "industries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lead_estimate_lines", force: :cascade do |t|
    t.string   "name",             limit: 255,               null: false
    t.integer  "unit_price",       limit: 4,                 null: false
    t.integer  "quantity",         limit: 4,                 null: false
    t.integer  "lead_estimate_id", limit: 4,                 null: false
    t.integer  "tax_rate",         limit: 4,     default: 0, null: false
    t.text     "detail",           limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lead_histories", force: :cascade do |t|
    t.datetime "approach_day"
    t.integer  "lead_history_status_id", limit: 4
    t.integer  "user_id",                limit: 4
    t.datetime "next_approach_day"
    t.text     "memo",                   limit: 65535
    t.integer  "lead_id",                limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "shipped_at"
  end

  add_index "lead_histories", ["lead_history_status_id"], name: "index_lead_histories_on_lead_history_status_id", using: :btree
  add_index "lead_histories", ["lead_id"], name: "index_lead_histories_on_lead_id", using: :btree
  add_index "lead_histories", ["user_id"], name: "index_lead_histories_on_user_id", using: :btree

  create_table "lead_history_attachments", force: :cascade do |t|
    t.integer  "lead_history_id", limit: 4
    t.string   "attachment",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lead_history_statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "progress",   limit: 255
    t.string   "color",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lead_interviews", force: :cascade do |t|
    t.integer  "regular_staff",    limit: 4
    t.integer  "nonregular_staff", limit: 4
    t.string   "solvency",         limit: 255
    t.string   "time",             limit: 255
    t.integer  "lead_id",          limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lead_interviews", ["lead_id"], name: "index_lead_interviews_on_lead_id", using: :btree

  create_table "leads", force: :cascade do |t|
    t.string   "name",             limit: 255,                   null: false
    t.string   "tel",              limit: 255,                   null: false
    t.string   "fax",              limit: 255
    t.string   "email",            limit: 255
    t.string   "person_name",      limit: 255
    t.string   "person_kana",      limit: 255
    t.string   "person_post",      limit: 255
    t.string   "url",              limit: 255
    t.string   "zipcode",          limit: 255
    t.string   "prefecture",       limit: 255
    t.string   "street",           limit: 255
    t.string   "building",         limit: 255
    t.text     "memo",             limit: 65535
    t.integer  "user_id",          limit: 4
    t.integer  "star",             limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city",             limit: 255
    t.string   "campaign",         limit: 255
    t.string   "campaign_detail",  limit: 255
    t.string   "corporation_name", limit: 255
    t.string   "sex",              limit: 255
    t.boolean  "dm_flg",                         default: false
    t.boolean  "contract_flg",                   default: false, null: false
    t.boolean  "mark_flg"
    t.boolean  "nego_flg"
  end

  add_index "leads", ["tel"], name: "index_leads_on_tel", unique: true, using: :btree
  add_index "leads", ["user_id"], name: "index_leads_on_user_id", using: :btree

  create_table "logs", force: :cascade do |t|
    t.integer  "company_id", limit: 4
    t.integer  "status_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by", limit: 255
  end

  create_table "order_sheet_lines", force: :cascade do |t|
    t.integer "order_sheet_id", limit: 4
    t.integer "price",          limit: 4
    t.date    "invoice_date"
    t.date    "payment_date"
    t.boolean "invoice_flg",                  default: false, null: false
    t.boolean "payment_flg",                  default: false, null: false
    t.text    "memo",           limit: 65535
  end

  create_table "order_sheets", force: :cascade do |t|
    t.string   "title",        limit: 255,                     null: false
    t.string   "send_to",      limit: 255,                     null: false
    t.date     "order_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",       limit: 255,   default: "draft", null: false
    t.text     "mention",      limit: 65535
    t.text     "course_info",  limit: 65535
    t.text     "memo",         limit: 65535
    t.text     "company_info", limit: 65535
  end

  create_table "periods", force: :cascade do |t|
    t.date     "day",                                         null: false
    t.time     "start_time",                                  null: false
    t.time     "end_time",                                    null: false
    t.time     "break_start"
    t.time     "break_end"
    t.integer  "teacher_id",    limit: 4
    t.integer  "course_id",     limit: 4
    t.text     "memo",          limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "resume_flg",                  default: false, null: false
    t.boolean  "report_flg",                  default: false, null: false
    t.string   "google_id",     limit: 255
    t.boolean  "equipment_flg",               default: false, null: false
    t.boolean  "attend_flg",                  default: false, null: false
    t.integer  "user_id",       limit: 4
  end

  add_index "periods", ["user_id"], name: "index_periods_on_user_id", using: :btree

  create_table "public_bill_lines", force: :cascade do |t|
    t.string   "name",           limit: 255,               null: false
    t.integer  "unit_price",     limit: 4,                 null: false
    t.integer  "quantity",       limit: 4,                 null: false
    t.integer  "public_bill_id", limit: 4,                 null: false
    t.integer  "tax_rate",       limit: 4,     default: 0, null: false
    t.text     "detail",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "public_bills", force: :cascade do |t|
    t.string   "name",         limit: 255,                   null: false
    t.date     "publish_date"
    t.boolean  "send_flg",                   default: false, null: false
    t.string   "company_name", limit: 255,                   null: false
    t.date     "invoice_date"
    t.date     "payment_date"
    t.text     "memo",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "public_estimate_lines", force: :cascade do |t|
    t.string   "name",               limit: 255,               null: false
    t.integer  "unit_price",         limit: 4,                 null: false
    t.integer  "quantity",           limit: 4,                 null: false
    t.integer  "public_estimate_id", limit: 4,                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tax_rate",           limit: 4,     default: 0, null: false
    t.text     "detail",             limit: 65535
  end

  create_table "public_estimates", force: :cascade do |t|
    t.integer  "client_id",    limit: 4,                         null: false
    t.date     "expired"
    t.boolean  "send_flg",                   default: false,     null: false
    t.text     "memo",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "client_type",  limit: 255,   default: "company", null: false
    t.string   "display_name", limit: 255
    t.date     "publish_date"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "name",          limit: 255,   null: false
    t.datetime "due_date"
    t.text     "memo",          limit: 65535
    t.datetime "complete_date"
    t.integer  "lead_id",       limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "teacher_order_courses", force: :cascade do |t|
    t.integer "teacher_order_id", limit: 4
    t.integer "course_id",        limit: 4
  end

  create_table "teacher_order_lines", force: :cascade do |t|
    t.integer "teacher_order_id", limit: 4
    t.integer "price",            limit: 4
    t.date    "payment_date"
    t.boolean "invoice_flg",                  default: false, null: false
    t.boolean "payment_flg",                  default: false, null: false
    t.string  "memo",             limit: 255
    t.date    "invoice_date"
  end

  create_table "teacher_order_periods", force: :cascade do |t|
    t.date     "day",                            null: false
    t.time     "start_time",                     null: false
    t.time     "end_time",                       null: false
    t.time     "break_start"
    t.time     "break_end"
    t.text     "memo",             limit: 65535
    t.integer  "teacher_order_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teacher_orders", force: :cascade do |t|
    t.integer  "teacher_id",   limit: 4
    t.text     "memo",         limit: 65535
    t.date     "order_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "students",     limit: 4
    t.string   "description",  limit: 255
    t.string   "price_detail", limit: 255
    t.string   "status",       limit: 255,   default: "draft", null: false
    t.text     "mention",      limit: 65535
    t.string   "period_type",  limit: 255,   default: "auto"
    t.integer  "course_id",    limit: 4
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "first_kanji",     limit: 255,               null: false
    t.string   "last_kanji",      limit: 255,               null: false
    t.string   "first_kana",      limit: 255,               null: false
    t.string   "last_kana",       limit: 255,               null: false
    t.integer  "work_possible",   limit: 4,     default: 0, null: false
    t.string   "genre",           limit: 255
    t.text     "memo",            limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "orientation_flg"
    t.boolean  "profile_flg"
    t.boolean  "photo_flg"
    t.boolean  "regist_flg"
    t.boolean  "contract_flg"
    t.integer  "bill",            limit: 4
    t.string   "tel",             limit: 255
    t.string   "email",           limit: 255
    t.integer  "director_id",     limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.boolean  "admin",                              default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255,   null: false
    t.integer  "item_id",    limit: 4,     null: false
    t.string   "event",      limit: 255,   null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object",     limit: 65535
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "estimates", "leads"
end
