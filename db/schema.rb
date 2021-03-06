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

ActiveRecord::Schema.define(version: 20160324034049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employment_applications", force: :cascade do |t|
    t.boolean  "active",             default: true
    t.text     "notes"
    t.boolean  "over_18"
    t.boolean  "any_shift"
    t.string   "any_shift_text"
    t.boolean  "overtime"
    t.boolean  "eligible_us"
    t.boolean  "accomodations"
    t.text     "accomodations_text"
    t.boolean  "convictions"
    t.text     "convictions_text"
    t.json     "skills"
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.text     "other_information"
    t.boolean  "certify"
    t.string   "location"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "facilities", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "phone"
    t.string   "fax"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "facilities_users", force: :cascade do |t|
    t.integer  "facility_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facilities_users", ["facility_id", "user_id"], name: "index_facilities_users_on_facility_id_and_user_id", using: :btree
  add_index "facilities_users", ["user_id", "facility_id"], name: "index_facilities_users_on_user_id_and_facility_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.integer  "resident_id"
    t.decimal  "total_due",   precision: 7, scale: 2
    t.decimal  "balance_due", precision: 7, scale: 2
    t.boolean  "paid",                                default: false
    t.string   "number"
    t.date     "due_date"
    t.text     "notes"
    t.text     "item",                                default: ""
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  create_table "invoices_payments", id: false, force: :cascade do |t|
    t.integer  "invoice_id", null: false
    t.integer  "payment_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoices_payments", ["invoice_id", "payment_id"], name: "index_invoices_payments_on_invoice_id_and_payment_id", using: :btree
  add_index "invoices_payments", ["payment_id", "invoice_id"], name: "index_invoices_payments_on_payment_id_and_invoice_id", using: :btree

  create_table "maintenance_requests", force: :cascade do |t|
    t.integer  "facility_id"
    t.integer  "requester_id"
    t.integer  "priority"
    t.boolean  "completed",      default: false, null: false
    t.date     "completed_date"
    t.string   "location"
    t.text     "description"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "resident_id"
    t.decimal  "amount",       precision: 7, scale: 2
    t.date     "receive_date"
    t.boolean  "deposited",                            default: false
    t.string   "method"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  create_table "residents", force: :cascade do |t|
    t.integer  "unit_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "contact_first_name"
    t.string   "contact_last_name"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.date     "move_in"
    t.date     "move_out"
    t.decimal  "rent",               precision: 7, scale: 2
    t.text     "notes",                                      default: ""
    t.boolean  "active",                                     default: true
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  create_table "units", force: :cascade do |t|
    t.integer  "facility_id"
    t.string   "number"
    t.string   "occupancy",   default: ""
    t.boolean  "active",      default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "role",                              null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email",             default: "",    null: false
    t.string   "password_digest",   default: "",    null: false
    t.string   "remember_digest"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
