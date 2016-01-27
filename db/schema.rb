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

ActiveRecord::Schema.define(version: 20160123001054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "facilities", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "phone"
    t.string   "fax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "resident_id"
    t.decimal  "amount_due"
    t.string   "status"
    t.string   "invoice_number"
    t.date     "invoice_date"
    t.date     "invoice_due_date"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "maintenance_requests", force: :cascade do |t|
    t.integer  "facility_id"
    t.string   "location"
    t.string   "description"
    t.string   "priority"
    t.boolean  "completed"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "invoice_id"
    t.decimal  "amount"
    t.date     "date"
    t.string   "check_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "residents", force: :cascade do |t|
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
    t.string   "unit"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "facility_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "role"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
