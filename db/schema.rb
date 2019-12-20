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

ActiveRecord::Schema.define(version: 2019_12_18_030602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "stylist_id"
    t.time "time_from"
    t.time "time_to"
    t.decimal "fee", default: "0.0"
    t.decimal "service_lat"
    t.decimal "service_long"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.bigint "service_ids", default: [], array: true
    t.bigint "schedule_id"
    t.string "card_token"
    t.decimal "service_amount", precision: 10, scale: 2
    t.string "notes"
    t.index ["client_id"], name: "index_bookings_on_client_id"
    t.index ["schedule_id"], name: "index_bookings_on_schedule_id"
    t.index ["stylist_id"], name: "index_bookings_on_stylist_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "facebook_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "customer_id"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "stylist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_favorites_on_client_id"
    t.index ["stylist_id"], name: "index_favorites_on_stylist_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "booking_id"
    t.bigint "client_id"
    t.bigint "stylist_id"
    t.text "text"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sender"
    t.index ["booking_id"], name: "index_messages_on_booking_id"
    t.index ["client_id"], name: "index_messages_on_client_id"
    t.index ["stylist_id"], name: "index_messages_on_stylist_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.text "message"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "booking_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "booking_id"
    t.string "coupon_code"
    t.integer "discount_percent"
    t.decimal "tip_fee"
    t.decimal "discount"
    t.decimal "amount"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "charge_id"
    t.index ["booking_id"], name: "index_payments_on_booking_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "text"
    t.float "rate", default: 0.0
    t.bigint "stylist_id"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id"
    t.index ["client_id"], name: "index_reviews_on_client_id"
    t.index ["stylist_id"], name: "index_reviews_on_stylist_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_ids", default: [], array: true
  end

  create_table "service_types", force: :cascade do |t|
    t.string "name"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_type_id"
    t.decimal "amount", precision: 10, scale: 2
    t.integer "status", default: 1
    t.integer "duration"
    t.index ["service_type_id"], name: "index_services_on_service_type_id"
  end

  create_table "stylist_schedules", force: :cascade do |t|
    t.bigint "stylist_id"
    t.bigint "schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "start_time"
    t.boolean "available", default: true
    t.index ["schedule_id"], name: "index_stylist_schedules_on_schedule_id"
    t.index ["stylist_id", "schedule_id", "start_time"], name: "index_stylist_id_and_schedule_id_and_start_time", unique: true
    t.index ["stylist_id"], name: "index_stylist_schedules_on_stylist_id"
  end

  create_table "stylist_services", force: :cascade do |t|
    t.bigint "stylist_id"
    t.bigint "service_id"
    t.index ["service_id"], name: "index_stylist_services_on_service_id"
    t.index ["stylist_id"], name: "index_stylist_services_on_stylist_id"
  end

  create_table "stylists", force: :cascade do |t|
    t.text "description"
    t.integer "welcome_kit", default: 0
    t.integer "service_type", default: 1
    t.integer "register_by"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "long", precision: 10, scale: 6
    t.integer "radius"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "years_of_experience", default: 0
    t.boolean "license_agreement"
    t.integer "has_smartphone", default: 0
    t.boolean "has_transportation"
    t.string "portfolio_link"
    t.boolean "is_eligible_to_work_in_us", default: false
    t.date "previous_contractor_date"
    t.boolean "has_conviction"
    t.boolean "agrees_to_unemployment_understanding"
    t.boolean "agrees_to_taxation_understanding"
    t.index ["user_id"], name: "index_stylists_on_user_id"
  end

  create_table "user_services", force: :cascade do |t|
    t.datetime "date", null: false
    t.string "comments"
    t.bigint "user_id"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_user_services_on_service_id"
    t.index ["user_id"], name: "index_user_services_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "role"
    t.string "gcm_id"
    t.string "device_type"
    t.string "device_id"
    t.integer "status", default: 1
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "postal_code"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "bookings", "clients"
  add_foreign_key "bookings", "schedules"
  add_foreign_key "bookings", "stylists"
  add_foreign_key "favorites", "clients"
  add_foreign_key "favorites", "stylists"
  add_foreign_key "messages", "bookings"
  add_foreign_key "messages", "clients"
  add_foreign_key "messages", "stylists"
  add_foreign_key "payments", "bookings"
  add_foreign_key "reviews", "clients"
  add_foreign_key "reviews", "stylists"
  add_foreign_key "services", "service_types"
  add_foreign_key "stylist_schedules", "schedules"
  add_foreign_key "stylist_schedules", "stylists"
  add_foreign_key "stylist_services", "services"
  add_foreign_key "stylist_services", "stylists"
end
