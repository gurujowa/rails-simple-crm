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

ActiveRecord::Schema.define(version: 20171108082225) do

  create_table "billing_plan_lines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "bill_date",                     null: false
    t.date     "accural_date",                  null: false
    t.text     "memo",            limit: 65535
    t.integer  "billing_plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price"
    t.index ["billing_plan_id"], name: "index_billing_plan_lines_on_billing_plan_id", using: :btree
  end

  create_table "billing_plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                         null: false
    t.integer  "tax_rate",     default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "publish_date"
    t.boolean  "send_flg",     default: false, null: false
    t.string   "display_name"
    t.integer  "lead_id",                      null: false
    t.boolean  "check_flg",    default: false, null: false
  end

  create_table "campaigns", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "bill",                     null: false
    t.integer  "sent",                     null: false
    t.date     "start_date"
    t.text     "memo",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "company_id",                                 null: false
    t.integer  "price",                                      null: false
    t.boolean  "invoice_flg",                default: false, null: false
    t.boolean  "payment_flg",                default: false, null: false
    t.date     "invoice_date"
    t.date     "payment_date"
    t.text     "memo",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "last_name",                       null: false
    t.string   "first_name"
    t.string   "last_kana"
    t.string   "first_kana"
    t.string   "tel"
    t.string   "fax"
    t.string   "mail"
    t.integer  "gender",                          null: false
    t.string   "official_position"
    t.integer  "company_id",                      null: false
    t.text     "memo",              limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.string   "client_name"
    t.string   "tel"
    t.string   "fax"
    t.string   "mail"
    t.string   "zipcode"
    t.string   "prefecture"
    t.string   "city"
    t.string   "address"
    t.string   "building"
    t.string   "created_by"
    t.string   "updated_by"
    t.integer  "industry_id",                    default: 1,          null: false
    t.integer  "campaign_id",                                         null: false
    t.string   "active_st",                      default: "notstart", null: false
    t.integer  "regular_staff"
    t.integer  "nonregular_staff"
    t.text     "memo",             limit: 65535
    t.string   "tel2"
    t.string   "fax2"
    t.string   "zipcode2"
    t.string   "prefecture2"
    t.string   "city2"
    t.string   "address2"
    t.string   "building2"
    t.index ["active_st"], name: "index_companies_on_active_st", using: :btree
    t.index ["campaign_id"], name: "index_companies_on_campaign_id", using: :btree
    t.index ["city"], name: "index_companies_on_city", using: :btree
    t.index ["client_name"], name: "index_companies_on_client_name", using: :btree
    t.index ["created_at"], name: "index_companies_on_created_at", using: :btree
    t.index ["created_by"], name: "index_companies_on_created_by", using: :btree
    t.index ["prefecture"], name: "index_companies_on_prefecture", using: :btree
    t.index ["tel"], name: "index_companies_on_tel", unique: true, using: :btree
    t.index ["updated_at"], name: "index_companies_on_updated_at", using: :btree
    t.index ["updated_by"], name: "index_companies_on_updated_by", using: :btree
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "company_id"
    t.text     "memo",       limit: 65535
    t.string   "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "con_type"
  end

  create_table "course_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.string  "address"
    t.string  "station"
    t.string  "responsible"
    t.string  "tel"
    t.boolean "projector"
    t.string  "projector_detail"
    t.boolean "board"
    t.string  "board_detail"
    t.integer "course_id"
    t.text    "memo",             limit: 65535
  end

  create_table "course_tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",                    null: false
    t.datetime "start",                    null: false
    t.datetime "end"
    t.boolean  "all_day"
    t.text     "memo",       limit: 65535
    t.integer  "course_id",                null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["course_id"], name: "index_course_tasks_on_course_id", using: :btree
  end

  create_table "courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.string   "station"
    t.string   "responsible"
    t.string   "tel"
    t.integer  "students"
    t.text     "memo",        limit: 65535
    t.integer  "user_id"
    t.string   "status",                    default: "draft"
    t.integer  "lead_id",                                     null: false
  end

  create_table "estimate_lines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                  null: false
    t.integer  "unit_price",                            null: false
    t.integer  "quantity",                              null: false
    t.integer  "estimate_id",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tax_rate",                  default: 0, null: false
    t.text     "detail",      limit: 65535
  end

  create_table "estimate_subsities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "price",       default: 0, null: false
    t.integer  "people"
    t.integer  "estimate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estimates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "expired"
    t.boolean  "send_flg",                   default: false, null: false
    t.text     "memo",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
    t.date     "publish_date"
    t.integer  "lead_id"
    t.index ["lead_id"], name: "fk_rails_2c1af8602b", using: :btree
  end

  create_table "industries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lead_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "lead_id",                                   null: false
    t.integer  "user_id",                                   null: false
    t.text     "memo",       limit: 65535,                  null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "category",                 default: "jimu", null: false
    t.index ["lead_id"], name: "index_lead_comments_on_lead_id", using: :btree
    t.index ["user_id"], name: "index_lead_comments_on_user_id", using: :btree
  end

  create_table "lead_contracts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "contract_date",                  null: false
    t.string   "name",                           null: false
    t.string   "company_category",               null: false
    t.string   "subsity_info"
    t.text     "memo",             limit: 65535
    t.integer  "price",                          null: false
    t.integer  "lead_id",                        null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["lead_id"], name: "index_lead_contracts_on_lead_id", using: :btree
  end

  create_table "lead_estimate_lines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                       null: false
    t.integer  "unit_price",                                 null: false
    t.integer  "quantity",                                   null: false
    t.integer  "lead_estimate_id",                           null: false
    t.integer  "tax_rate",                       default: 0, null: false
    t.text     "detail",           limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lead_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "approach_day"
    t.integer  "lead_history_status_id"
    t.integer  "user_id"
    t.datetime "next_approach_day"
    t.text     "memo",                   limit: 65535
    t.integer  "lead_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "shipped_at"
    t.index ["lead_history_status_id"], name: "index_lead_histories_on_lead_history_status_id", using: :btree
    t.index ["lead_id"], name: "index_lead_histories_on_lead_id", using: :btree
    t.index ["user_id"], name: "index_lead_histories_on_user_id", using: :btree
  end

  create_table "lead_history_attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "lead_history_id"
    t.string   "attachment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lead_history_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "progress"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "display_flg", default: true, null: false
  end

  create_table "lead_interviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "regular_staff"
    t.integer  "nonregular_staff"
    t.string   "solvency"
    t.string   "time"
    t.integer  "lead_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["lead_id"], name: "index_lead_interviews_on_lead_id", using: :btree
  end

  create_table "lead_subsities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.date     "start"
    t.date     "end"
    t.text     "memo",       limit: 65535
    t.integer  "lead_id"
    t.integer  "subsity_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["lead_id"], name: "index_lead_subsities_on_lead_id", using: :btree
    t.index ["subsity_id"], name: "index_lead_subsities_on_subsity_id", using: :btree
  end

  create_table "lead_tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                          null: false
    t.date     "due_date",                      null: false
    t.date     "complete_date"
    t.text     "memo",            limit: 65535
    t.integer  "lead_id"
    t.integer  "lead_subsity_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "leads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                           null: false
    t.string   "tel",                                            null: false
    t.string   "fax"
    t.string   "email"
    t.string   "person_name"
    t.string   "person_kana"
    t.string   "person_post"
    t.string   "url"
    t.string   "zipcode"
    t.string   "prefecture"
    t.string   "street"
    t.string   "building"
    t.text     "memo",             limit: 65535
    t.integer  "user_id"
    t.integer  "star"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
    t.string   "campaign"
    t.string   "campaign_detail"
    t.string   "corporation_name"
    t.string   "sex"
    t.boolean  "dm_flg",                         default: false
    t.boolean  "contract_flg",                   default: false, null: false
    t.boolean  "mark_flg"
    t.boolean  "nego_flg"
    t.string   "airtable_id"
    t.index ["tel"], name: "index_leads_on_tel", unique: true, using: :btree
    t.index ["user_id"], name: "index_leads_on_user_id", using: :btree
  end

  create_table "logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "company_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
  end

  create_table "order_sheet_lines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "order_sheet_id"
    t.integer "price"
    t.date    "invoice_date"
    t.date    "payment_date"
    t.boolean "invoice_flg",                  default: false, null: false
    t.boolean "payment_flg",                  default: false, null: false
    t.text    "memo",           limit: 65535
  end

  create_table "order_sheets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",                                        null: false
    t.string   "send_to",                                      null: false
    t.date     "order_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",                     default: "draft", null: false
    t.text     "mention",      limit: 65535
    t.text     "course_info",  limit: 65535
    t.text     "memo",         limit: 65535
    t.text     "company_info", limit: 65535
  end

  create_table "period_tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "period_id",                  null: false
    t.integer  "task_type",                  null: false
    t.boolean  "checked",    default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["period_id"], name: "index_period_tasks_on_period_id", using: :btree
  end

  create_table "periods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "day",                                                  null: false
    t.time     "start_time",                                           null: false
    t.time     "end_time",                                             null: false
    t.time     "break_start"
    t.time     "break_end"
    t.integer  "teacher_id"
    t.integer  "course_id"
    t.text     "memo",              limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "resume_flg",                      default: false,      null: false
    t.boolean  "report_flg",                      default: false,      null: false
    t.string   "google_id"
    t.boolean  "equipment_flg",                   default: false,      null: false
    t.boolean  "attend_flg",                      default: false,      null: false
    t.integer  "user_id"
    t.integer  "course_address_id"
    t.datetime "attend_date"
    t.string   "resume_status",                   default: "notstart", null: false
    t.integer  "price"
    t.integer  "train_cost"
    t.integer  "order_sheet_id"
    t.integer  "order_avail",                     default: 0,          null: false
    t.integer  "students"
    t.string   "theme"
    t.index ["course_address_id"], name: "index_periods_on_course_address_id", using: :btree
    t.index ["order_sheet_id"], name: "index_periods_on_order_sheet_id", using: :btree
    t.index ["user_id"], name: "index_periods_on_user_id", using: :btree
  end

  create_table "public_bill_lines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                     null: false
    t.integer  "unit_price",                               null: false
    t.integer  "quantity",                                 null: false
    t.integer  "public_bill_id",                           null: false
    t.integer  "tax_rate",                     default: 0, null: false
    t.text     "detail",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "public_bills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                       null: false
    t.date     "publish_date"
    t.boolean  "send_flg",                   default: false, null: false
    t.string   "company_name",                               null: false
    t.date     "invoice_date"
    t.date     "payment_date"
    t.text     "memo",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bill_number"
  end

  create_table "public_estimate_lines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                         null: false
    t.integer  "unit_price",                                   null: false
    t.integer  "quantity",                                     null: false
    t.integer  "public_estimate_id",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tax_rate",                         default: 0, null: false
    t.text     "detail",             limit: 65535
  end

  create_table "public_estimates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "client_id",                                      null: false
    t.date     "expired"
    t.boolean  "send_flg",                   default: false,     null: false
    t.text     "memo",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "client_type",                default: "company", null: false
    t.string   "display_name"
    t.date     "publish_date"
  end

  create_table "subsities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "trello_board"
    t.string   "trello_list"
  end

  create_table "subsity_tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                   null: false
    t.integer  "month",      default: 0, null: false
    t.integer  "day",        default: 0, null: false
    t.string   "depend",                 null: false
    t.integer  "subsity_id",             null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "taggings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",                       collation: "utf8_bin"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                        null: false
    t.datetime "due_date"
    t.text     "memo",          limit: 65535
    t.datetime "complete_date"
    t.integer  "lead_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "teacher_bookings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "booking_date"
    t.integer  "teacher_id"
    t.datetime "expired_at"
    t.string   "name"
    t.index ["teacher_id"], name: "index_teacher_bookings_on_teacher_id", using: :btree
  end

  create_table "teacher_order_courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "teacher_order_id"
    t.integer "course_id"
  end

  create_table "teacher_order_lines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "teacher_order_id"
    t.integer "price"
    t.date    "payment_date"
    t.boolean "invoice_flg",      default: false, null: false
    t.boolean "payment_flg",      default: false, null: false
    t.string  "memo"
    t.date    "invoice_date"
  end

  create_table "teacher_order_periods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date     "day",                            null: false
    t.time     "start_time",                     null: false
    t.time     "end_time",                       null: false
    t.time     "break_start"
    t.time     "break_end"
    t.text     "memo",             limit: 65535
    t.integer  "teacher_order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teacher_orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "teacher_id"
    t.text     "memo",         limit: 65535
    t.date     "order_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "students"
    t.string   "description"
    t.string   "price_detail"
    t.string   "status",                     default: "draft", null: false
    t.text     "mention",      limit: 65535
    t.string   "period_type",                default: "auto"
    t.integer  "course_id"
  end

  create_table "teachers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "first_kanji",                                  null: false
    t.string   "last_kanji",                                   null: false
    t.string   "first_kana",                                   null: false
    t.string   "last_kana",                                    null: false
    t.integer  "work_possible",                 default: 0,    null: false
    t.string   "genre"
    t.text     "memo",            limit: 65535
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
    t.integer  "director_id"
    t.boolean  "attend_mail_flg",               default: true, null: false
    t.boolean  "send_alert_flg",                default: true, null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",               default: "",    null: false
    t.string   "encrypted_password",  default: "",    null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",               default: false, null: false
    t.integer  "faild_attempts",      default: 0,     null: false
    t.datetime "locked_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "item_type",                null: false
    t.integer  "item_id",                  null: false
    t.string   "event",                    null: false
    t.string   "whodunnit"
    t.text     "object",     limit: 65535
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

  add_foreign_key "estimates", "leads"
  add_foreign_key "lead_comments", "leads"
  add_foreign_key "lead_comments", "users"
  add_foreign_key "lead_contracts", "leads"
  add_foreign_key "lead_subsities", "leads"
  add_foreign_key "lead_subsities", "subsities"
  add_foreign_key "period_tasks", "periods"
  add_foreign_key "periods", "course_addresses"
  add_foreign_key "periods", "order_sheets"
  add_foreign_key "teacher_bookings", "teachers"
end
