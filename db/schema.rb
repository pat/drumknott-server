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

ActiveRecord::Schema.define(version: 20160225055153) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "duties_activity_records", force: :cascade do |t|
    t.string   "name",                               null: false
    t.integer  "duty_record_id",                     null: false
    t.integer  "position",                           null: false
    t.string   "status",         default: "pending", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "failures",       default: "[]"
  end

  add_index "duties_activity_records", ["duty_record_id"], name: "index_duties_activity_records_on_duty_record_id", using: :btree
  add_index "duties_activity_records", ["name"], name: "index_duties_activity_records_on_name", using: :btree

  create_table "duties_duty_records", force: :cascade do |t|
    t.string   "name",                      null: false
    t.text     "data",       default: "{}"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "duties_duty_records", ["created_at"], name: "index_duties_duty_records_on_created_at", order: {"created_at"=>:desc}, using: :btree
  add_index "duties_duty_records", ["name"], name: "index_duties_duty_records_on_name", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.integer  "user_id",                        null: false
    t.string   "stripe_invoice_id",              null: false
    t.datetime "invoiced_at",                    null: false
    t.json     "data",              default: {}, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.datetime "sent_at"
  end

  add_index "invoices", ["stripe_invoice_id"], name: "index_invoices_on_stripe_invoice_id", unique: true, using: :btree
  add_index "invoices", ["user_id", "invoiced_at"], name: "index_invoices_on_user_id_and_invoiced_at", order: {"invoiced_at"=>:desc}, using: :btree
  add_index "invoices", ["user_id"], name: "index_invoices_on_user_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.integer  "site_id",        null: false
    t.string   "name",           null: false
    t.string   "path",           null: false
    t.text     "content"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "deactivated_at"
  end

  add_index "pages", ["deactivated_at"], name: "index_pages_on_deactivated_at", using: :btree
  add_index "pages", ["site_id", "path"], name: "index_pages_on_site_id_and_path", unique: true, using: :btree
  add_index "pages", ["site_id"], name: "index_pages_on_site_id", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "name",                                       null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "key",                                        null: false
    t.integer  "user_id"
    t.string   "stripe_subscription_id"
    t.string   "status",                 default: "pending", null: false
    t.string   "status_message"
    t.json     "cache",                  default: {},        null: false
  end

  add_index "sites", ["key"], name: "index_sites_on_key", unique: true, using: :btree
  add_index "sites", ["name"], name: "index_sites_on_name", unique: true, using: :btree
  add_index "sites", ["user_id"], name: "index_sites_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "stripe_customer_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "country",                default: "AU", null: false
    t.json     "cache",                  default: {},   null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
