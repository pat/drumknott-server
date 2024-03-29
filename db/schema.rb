# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2020_11_23_050103) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "duties_activity_records", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.integer "duty_record_id", null: false
    t.integer "position", null: false
    t.string "status", default: "pending", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.text "failures", default: "[]"
    t.index ["duty_record_id"], name: "index_duties_activity_records_on_duty_record_id"
    t.index ["name"], name: "index_duties_activity_records_on_name"
  end

  create_table "duties_duty_records", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.text "data", default: "{}"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["created_at"], name: "index_duties_duty_records_on_created_at", order: :desc
    t.index ["name"], name: "index_duties_duty_records_on_name"
  end

  create_table "invoices", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "stripe_invoice_id", null: false
    t.datetime "invoiced_at", precision: nil, null: false
    t.json "data", default: {}, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "sent_at", precision: nil
    t.index ["stripe_invoice_id"], name: "index_invoices_on_stripe_invoice_id", unique: true
    t.index ["user_id", "invoiced_at"], name: "index_invoices_on_user_id_and_invoiced_at", order: { invoiced_at: :desc }
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "name", null: false
    t.string "path", null: false
    t.text "content"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "deactivated_at", precision: nil
    t.index ["deactivated_at"], name: "index_pages_on_deactivated_at"
    t.index ["site_id", "path"], name: "index_pages_on_site_id_and_path", unique: true
    t.index ["site_id"], name: "index_pages_on_site_id"
  end

  create_table "sites", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "key", null: false
    t.integer "user_id"
    t.string "stripe_subscription_id"
    t.string "status", default: "pending", null: false
    t.string "status_message"
    t.json "cache", default: {}, null: false
    t.index ["key"], name: "index_sites_on_key", unique: true
    t.index ["name"], name: "index_sites_on_name", unique: true
    t.index ["user_id"], name: "index_sites_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "stripe_customer_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "country", default: "AU", null: false
    t.json "cache", default: {}, null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
